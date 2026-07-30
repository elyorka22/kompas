import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/utils/date_utils.dart';
import 'package:kompas/domain/entities/coach_balance.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/entities/learner_context.dart';
import 'package:kompas/domain/entities/learning_strategy.dart';
import 'package:kompas/domain/enums/goal_enums.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/services/coach/coach_pedagogy.dart';
import 'package:kompas/services/coach/learner_context_loader.dart';
import 'package:kompas/services/compass/practice_mode_catalog.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

/// Coach Engine v1 — offline educational brain.
///
/// Owns pedagogy. Never calls an LLM. Every recommendation includes reasons.
/// Compass Engine runs sessions; Memory sources feed context; Coach decides.
class CoachEngineService {
  CoachEngineService({
    required LearnerContextLoader contextLoader,
    CoachPedagogy? pedagogy,
  })  : _loader = contextLoader,
        _pedagogy = pedagogy ?? const CoachPedagogy();

  final LearnerContextLoader _loader;
  final CoachPedagogy _pedagogy;

  Future<Result<LearningStrategy>> generateLearningStrategy({
    required String userId,
  }) async {
    final contextResult = await _loader.load(userId);
    if (contextResult.isFailure) return Err(contextResult.failureOrNull!);
    final context = contextResult.valueOrNull!;
    return Success(_strategyFrom(context));
  }

  Future<Result<CoachedRecommendation<Exercise>>> recommendExercise({
    required String userId,
    PracticeMode? preferredMode,
  }) async {
    final contextResult = await _loader.load(userId);
    if (contextResult.isFailure) return Err(contextResult.failureOrNull!);
    return Success(
      _pedagogy.recommendExercise(
        contextResult.valueOrNull!,
        preferredMode: preferredMode,
      ),
    );
  }

  Future<Result<CoachedRecommendation<String>>> recommendTopic({
    required String userId,
  }) async {
    final contextResult = await _loader.load(userId);
    if (contextResult.isFailure) return Err(contextResult.failureOrNull!);
    return Success(_pedagogy.recommendTopic(contextResult.valueOrNull!));
  }

  Future<Result<CoachedRecommendation<DailyMission>>> recommendMission({
    required String userId,
  }) async {
    final contextResult = await _loader.load(userId);
    if (contextResult.isFailure) return Err(contextResult.failureOrNull!);
    final context = contextResult.valueOrNull!;

    if (context.todaysMissions.isNotEmpty) {
      final pending = context.todaysMissions
          .where((mission) => mission.status != MissionStatus.completed)
          .toList();
      final pick = pending.isEmpty ? context.todaysMissions.first : pending.first;
      final reasons = <RecommendationReason>[
        RecommendationReason(
          code: 'existing_mission',
          message: 'Continue today’s mission: ${pick.title}.',
        ),
      ];
      if (pick.skillId != null) {
        reasons.add(
          RecommendationReason(
            code: 'mission_skill_focus',
            message:
                'Mission focuses on ${DefaultSkillCatalog.byId(pick.skillId!)?.title ?? pick.skillId}.',
          ),
        );
      }
      return Success(
        CoachedRecommendation(value: pick, reasons: reasons, confidence: 0.85),
      );
    }

    final mode = _pedagogy.recommendMode(context);
    final now = context.asOf;
    final mission = DailyMission(
      id: 'coach_mission_${userId}_${KompasDateUtils.dayKey(now)}',
      userId: userId,
      type: MissionType.practiceSkill,
      status: MissionStatus.pending,
      title: 'Practice ${PracticeModeCatalog.title(mode.value)}',
      description: mode.reasons.map((reason) => reason.message).join(' '),
      targetValue: 1,
      skillId: PracticeModeCatalog.primarySkillId(mode.value),
      dayKey: KompasDateUtils.dayKey(now),
      createdAt: now,
      updatedAt: now,
    );

    return Success(
      CoachedRecommendation(
        value: mission,
        reasons: [
          ...mode.reasons,
          const RecommendationReason(
            code: 'generated_mission',
            message: 'No daily missions yet — Coach generated a focus mission.',
          ),
        ],
        confidence: mode.confidence,
      ),
    );
  }

  Future<Result<CoachedRecommendation<List<Expression>>>> recommendWords({
    required String userId,
    int limit = 8,
  }) async {
    final contextResult = await _loader.load(userId);
    if (contextResult.isFailure) return Err(contextResult.failureOrNull!);
    final words = _pedagogy.reviewWords(contextResult.valueOrNull!, limit: limit);
    return Success(
      CoachedRecommendation(
        value: words,
        reasons: [
          RecommendationReason(
            code: 'sm2_due',
            message: words.isEmpty
                ? 'No words are due for review right now.'
                : '${words.length} word(s)/phrase(s) are due on the SM-2 schedule.',
          ),
        ],
        confidence: words.isEmpty ? 0.5 : 0.9,
      ),
    );
  }

  Future<Result<CoachedRecommendation<List<Expression>>>>
      recommendExpressions({
    required String userId,
    int limit = 5,
  }) async {
    final contextResult = await _loader.load(userId);
    if (contextResult.isFailure) return Err(contextResult.failureOrNull!);
    final items =
        _pedagogy.practiceExpressions(contextResult.valueOrNull!, limit: limit);
    return Success(
      CoachedRecommendation(
        value: items,
        reasons: [
          RecommendationReason(
            code: 'learning_expressions',
            message: items.isEmpty
                ? 'No learning expressions queued.'
                : 'Practice ${items.length} expression(s) still in learning/review strength.',
          ),
        ],
        confidence: items.isEmpty ? 0.5 : 0.85,
      ),
    );
  }

  Future<Result<CoachedRecommendation<ExerciseDifficulty>>>
      recommendDifficulty({
    required String userId,
  }) async {
    final contextResult = await _loader.load(userId);
    if (contextResult.isFailure) return Err(contextResult.failureOrNull!);
    return Success(
      _pedagogy.recommendDifficulty(contextResult.valueOrNull!),
    );
  }

  Future<Result<CoachedRecommendation<ConversationGoal>>>
      recommendConversationGoal({
    required String userId,
  }) async {
    final contextResult = await _loader.load(userId);
    if (contextResult.isFailure) return Err(contextResult.failureOrNull!);
    final context = contextResult.valueOrNull!;
    final mode = _pedagogy.recommendMode(context);
    final topic = _pedagogy.recommendTopic(context);
    final duration = _pedagogy.recommendSpeakingSeconds(context);

    final goal = ConversationGoal(
      title: PracticeModeCatalog.title(mode.value),
      prompt:
          '${PracticeModeCatalog.defaultPrompt(mode.value)} Topic: ${topic.value}.',
      mode: mode.value,
      targetSpeakingSeconds: duration.value,
      reasons: [
        ...mode.reasons,
        ...topic.reasons,
        ...duration.reasons,
      ],
    );

    return Success(
      CoachedRecommendation(
        value: goal,
        reasons: goal.reasons,
        confidence: mode.confidence,
      ),
    );
  }

  Future<Result<DailyBalance>> evaluateDailyBalance({
    required String userId,
    DateTime? date,
  }) async {
    final contextResult = await _loader.load(userId);
    if (contextResult.isFailure) return Err(contextResult.failureOrNull!);
    final context = contextResult.valueOrNull!;
    final day = date ?? context.asOf;
    final dayKey = KompasDateUtils.dayKey(day);

    final todays = context.exerciseHistory.where((entry) {
      return KompasDateUtils.dayKey(entry.completedAt) == dayKey;
    }).toList();

    final modeCounts = <PracticeMode, int>{};
    final skillCounts = <String, int>{};
    for (final entry in todays) {
      modeCounts[entry.mode] = (modeCounts[entry.mode] ?? 0) + 1;
      skillCounts[entry.primarySkillId] =
          (skillCounts[entry.primarySkillId] ?? 0) + 1;
    }

    PracticeMode? overused;
    if (todays.length >= 3) {
      final sorted = modeCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      if (sorted.isNotEmpty && sorted.first.value / todays.length >= 0.67) {
        overused = sorted.first.key;
      }
    }

    final neglected = _pedagogy.findNeglectedSkill(context);
    final reasons = <RecommendationReason>[];
    var balanced = true;
    if (overused != null) {
      balanced = false;
      reasons.add(
        RecommendationReason(
          code: 'daily_mode_overuse',
          message:
              'Today is dominated by ${PracticeModeCatalog.title(overused)}.',
        ),
      );
    }
    if (neglected != null && neglected.daysSince >= 10) {
      balanced = false;
      reasons.add(
        RecommendationReason(
          code: 'daily_neglected_skill',
          message:
              '${neglected.title} has not been practiced for ${neglected.daysSince} days.',
        ),
      );
    }
    if (reasons.isEmpty) {
      reasons.add(
        const RecommendationReason(
          code: 'daily_balanced',
          message: 'Today’s practice mix looks balanced enough.',
        ),
      );
    }

    return Success(
      DailyBalance(
        dayKey: dayKey,
        modeCounts: modeCounts,
        skillCounts: skillCounts,
        totalExercises: todays.length,
        isBalanced: balanced,
        overusedMode: overused,
        neglectedSkillId: neglected?.skillId,
        reasons: reasons,
      ),
    );
  }

  Future<Result<WeeklyBalance>> evaluateWeeklyBalance({
    required String userId,
    DateTime? asOf,
  }) async {
    final contextResult = await _loader.load(userId);
    if (contextResult.isFailure) return Err(contextResult.failureOrNull!);
    final context = contextResult.valueOrNull!;
    final end = asOf ?? context.asOf;
    final start = end.subtract(const Duration(days: 6));
    final weekStart = KompasDateUtils.dayKey(start);

    final weekEntries = context.exerciseHistory.where((entry) {
      return !entry.completedAt.isBefore(KompasDateUtils.startOfDay(start)) &&
          !entry.completedAt.isAfter(end);
    }).toList();

    final modeCounts = <PracticeMode, int>{};
    final skillCounts = <String, int>{};
    final activeDays = <String>{};
    for (final entry in weekEntries) {
      modeCounts[entry.mode] = (modeCounts[entry.mode] ?? 0) + 1;
      skillCounts[entry.primarySkillId] =
          (skillCounts[entry.primarySkillId] ?? 0) + 1;
      activeDays.add(KompasDateUtils.dayKey(entry.completedAt));
    }

    PracticeMode? dominant;
    if (weekEntries.isNotEmpty) {
      final sorted = modeCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      dominant = sorted.first.key;
      if (sorted.first.value / weekEntries.length < 0.45) {
        dominant = null;
      }
    }

    final neglected = _pedagogy.findNeglectedSkill(context);
    final speakingSeconds = context.recentSessions
        .where(
          (session) =>
              session.startedAt != null &&
              !session.startedAt!.isBefore(KompasDateUtils.startOfDay(start)),
        )
        .fold<int>(0, (sum, session) => sum + session.speakingSeconds);

    final reasons = <RecommendationReason>[];
    var balanced = true;
    if (dominant != null) {
      balanced = false;
      reasons.add(
        RecommendationReason(
          code: 'weekly_dominant_mode',
          message:
              'This week is dominated by ${PracticeModeCatalog.title(dominant)}.',
        ),
      );
    }
    if (neglected != null && neglected.daysSince >= 10) {
      balanced = false;
      reasons.add(
        RecommendationReason(
          code: 'weekly_neglected_skill',
          message:
              '${neglected.title} neglected for ${neglected.daysSince} days.',
        ),
      );
    }
    if (activeDays.length <= 2 && weekEntries.isNotEmpty) {
      balanced = false;
      reasons.add(
        RecommendationReason(
          code: 'weekly_consistency',
          message:
              'Only ${activeDays.length} active day(s) this week — consistency needs work.',
        ),
      );
    }
    if (reasons.isEmpty) {
      reasons.add(
        const RecommendationReason(
          code: 'weekly_balanced',
          message: 'Weekly practice mix looks healthy.',
        ),
      );
    }

    return Success(
      WeeklyBalance(
        weekStartDayKey: weekStart,
        activeDays: activeDays.length,
        modeCounts: modeCounts,
        skillCounts: skillCounts,
        totalSpeakingSeconds: speakingSeconds,
        isBalanced: balanced,
        dominantMode: dominant,
        neglectedSkillId: neglected?.skillId,
        reasons: reasons,
      ),
    );
  }

  /// Convenience for tests / callers that already have a loaded context.
  LearningStrategy strategyFromContext(LearnerContext context) =>
      _strategyFrom(context);

  LearningStrategy _strategyFrom(LearnerContext context) {
    final mode = _pedagogy.recommendMode(context);
    final difficulty = _pedagogy.recommendDifficulty(context);
    final exercise = _pedagogy.recommendExercise(
      context,
      preferredMode: mode.value,
    );
    final topic = _pedagogy.recommendTopic(context);
    final duration = _pedagogy.recommendSpeakingSeconds(context);
    final words = _pedagogy.reviewWords(context);
    final expressions = _pedagogy.practiceExpressions(context);
    final neglected = _pedagogy.findNeglectedSkill(context);

    PracticeMode? challenge;
    final challengeReasons = <RecommendationReason>[];
    if (difficulty.value != ExerciseDifficulty.starter) {
      challenge = mode.value;
      challengeReasons.addAll(difficulty.reasons);
    } else if (neglected != null) {
      final modes = PracticeModeCatalog.modesForSkill(neglected.skillId);
      if (modes.isNotEmpty) {
        challenge = modes.first;
        challengeReasons.add(
          RecommendationReason(
            code: 'challenge_neglected',
            message:
                'Challenge: return to ${neglected.title} after ${neglected.daysSince} days away.',
          ),
        );
      }
    }

    final prioritySkills = <String>[
      if (context.profile.weakestSkillIds.isNotEmpty)
        context.profile.weakestSkillIds.first,
      if (neglected != null) neglected.skillId,
      PracticeModeCatalog.primarySkillId(mode.value),
    ];

    final reasons = <RecommendationReason>[
      ...mode.reasons,
      ...difficulty.reasons,
      ...duration.reasons,
      if (context.preferredLearningHour != null &&
          context.preferredLearningHour! >= 20)
        const RecommendationReason(
          code: 'evening_learner',
          message:
              'User usually practices after 20:00 — schedule missions for evening.',
        ),
    ];

    return LearningStrategy(
      dayKey: KompasDateUtils.dayKey(context.asOf),
      primaryMode: mode.value,
      prioritySkillIds: prioritySkills.toSet().toList(),
      priorityExerciseIds: [exercise.value.id],
      difficulty: difficulty.value,
      suggestedSpeakingSeconds: duration.value,
      wordsToReview: words.map((item) => item.targetText).toList(),
      expressionsToPractice:
          expressions.map((item) => item.targetText).toList(),
      topicsToAvoid: List.of(context.avoidedTopics),
      suggestedTopic: topic.value,
      challengeMode: challenge,
      challengeReasons: challengeReasons,
      reasons: reasons,
    );
  }
}
