import 'package:kompas/core/utils/date_utils.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/entities/learner_context.dart';
import 'package:kompas/domain/enums/memory_enums.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/services/compass/practice_mode_catalog.dart';
import 'package:kompas/shared/catalog/default_exercise_catalog.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

/// Pure pedagogical rules. No I/O. Every decision returns reasons.
class CoachPedagogy {
  const CoachPedagogy();

  CoachedRecommendation<PracticeMode> recommendMode(LearnerContext context) {
    final reasons = <RecommendationReason>[];
    final neglected = findNeglectedSkill(context);
    if (neglected != null) {
      final modes = PracticeModeCatalog.modesForSkill(neglected.skillId);
      if (modes.isNotEmpty) {
        reasons.add(
          RecommendationReason(
            code: 'neglected_skill',
            message:
                'User has not practiced ${neglected.title} for ${neglected.daysSince} days.',
          ),
        );
        return CoachedRecommendation(
          value: modes.first,
          reasons: reasons,
          confidence: 0.9,
        );
      }
    }

    final weakId = context.profile.weakestSkillIds.isEmpty
        ? null
        : context.profile.weakestSkillIds.first;
    if (weakId != null) {
      final modes = PracticeModeCatalog.modesForSkill(weakId);
      if (modes.isNotEmpty) {
        final skill = DefaultSkillCatalog.byId(weakId);
        reasons.add(
          RecommendationReason(
            code: 'weak_skill',
            message:
                '${skill?.title ?? 'A core skill'} is currently weak — prioritize targeted practice.',
          ),
        );
        return CoachedRecommendation(
          value: modes.first,
          reasons: reasons,
          confidence: 0.85,
        );
      }
    }

    if (_isModeDominant(context, PracticeMode.explainWord, ratio: 0.5)) {
      reasons.add(
        const RecommendationReason(
          code: 'rebalance_vocabulary',
          message:
              'User mostly practiced Vocabulary — recommend Conversation to rebalance.',
        ),
      );
      return const CoachedRecommendation(
        value: PracticeMode.tellAboutDay,
        reasons: [
          RecommendationReason(
            code: 'rebalance_vocabulary',
            message:
                'User mostly practiced Vocabulary — recommend Conversation to rebalance.',
          ),
        ],
        confidence: 0.8,
      );
    }

    if (_speakingDurationDecreasing(context)) {
      reasons.add(
        const RecommendationReason(
          code: 'speaking_duration_down',
          message:
              'Speaking duration is decreasing — recommend storytelling for longer turns.',
        ),
      );
      return const CoachedRecommendation(
        value: PracticeMode.continueStory,
        reasons: [
          RecommendationReason(
            code: 'speaking_duration_down',
            message:
                'Speaking duration is decreasing — recommend storytelling for longer turns.',
          ),
        ],
        confidence: 0.8,
      );
    }

    final favorite = context.favoriteModes.isEmpty
        ? PracticeMode.tellAboutDay
        : context.favoriteModes.first;
    reasons.add(
      RecommendationReason(
        code: 'preferred_mode',
        message:
            'Continue with ${PracticeModeCatalog.title(favorite)} based on recent preference.',
      ),
    );
    return CoachedRecommendation(
      value: favorite,
      reasons: reasons,
      confidence: 0.65,
    );
  }

  CoachedRecommendation<Exercise> recommendExercise(
    LearnerContext context, {
    PracticeMode? preferredMode,
  }) {
    final modeRec = preferredMode == null
        ? recommendMode(context)
        : CoachedRecommendation(
            value: preferredMode,
            reasons: [
              RecommendationReason(
                code: 'requested_mode',
                message:
                    'Mode requested: ${PracticeModeCatalog.title(preferredMode)}.',
              ),
            ],
          );

    final difficulty = recommendDifficulty(context);
    final pool = DefaultExerciseCatalog.byMode(modeRec.value);
    final recentIds = context.exerciseHistory
        .take(5)
        .map((entry) => entry.exerciseId)
        .toSet();

    Exercise? pick;
    for (final exercise in pool) {
      if (recentIds.contains(exercise.id)) continue;
      if (exercise.difficulty == difficulty.value ||
          difficulty.value == ExerciseDifficulty.core) {
        pick = exercise;
        if (exercise.difficulty == difficulty.value) break;
      }
    }
    pick ??= pool.isEmpty ? DefaultExerciseCatalog.active.first : pool.first;

    final reasons = <RecommendationReason>[
      ...modeRec.reasons,
      ...difficulty.reasons,
      RecommendationReason(
        code: 'exercise_match',
        message:
            'Selected “${pick.title}” to train ${DefaultSkillCatalog.byId(pick.primarySkillId)?.title ?? pick.primarySkillId}.',
      ),
    ];

    return CoachedRecommendation(
      value: pick,
      reasons: reasons,
      confidence: modeRec.confidence,
    );
  }

  CoachedRecommendation<ExerciseDifficulty> recommendDifficulty(
    LearnerContext context,
  ) {
    final recent = context.exerciseHistory.take(8).toList();
    if (recent.isEmpty) {
      return const CoachedRecommendation(
        value: ExerciseDifficulty.starter,
        reasons: [
          RecommendationReason(
            code: 'new_learner',
            message: 'No recent history — start with starter difficulty.',
          ),
        ],
        confidence: 0.7,
      );
    }

    final starterCount = recent.where((entry) {
      final exercise = DefaultExerciseCatalog.byId(entry.exerciseId);
      return exercise?.difficulty == ExerciseDifficulty.starter;
    }).length;

    if (starterCount / recent.length >= 0.7) {
      return const CoachedRecommendation(
        value: ExerciseDifficulty.core,
        reasons: [
          RecommendationReason(
            code: 'ease_bias',
            message:
                'User repeatedly chose easy exercises — increase challenge level.',
          ),
        ],
        confidence: 0.88,
      );
    }

    final stretchCount = recent.where((entry) {
      final exercise = DefaultExerciseCatalog.byId(entry.exerciseId);
      return exercise?.difficulty == ExerciseDifficulty.stretch;
    }).length;

    if (stretchCount / recent.length >= 0.6) {
      return const CoachedRecommendation(
        value: ExerciseDifficulty.stretch,
        reasons: [
          RecommendationReason(
            code: 'high_challenge_ready',
            message: 'Recent practice is already stretch-level — keep the challenge.',
          ),
        ],
        confidence: 0.75,
      );
    }

    return const CoachedRecommendation(
      value: ExerciseDifficulty.core,
      reasons: [
        RecommendationReason(
          code: 'steady_core',
          message: 'Maintain core difficulty for steady growth.',
        ),
      ],
      confidence: 0.7,
    );
  }

  CoachedRecommendation<String> recommendTopic(LearnerContext context) {
    final avoided = context.avoidedTopics.toSet();
    final recent = context.recentTopics.toSet();

    const catalog = <String>[
      'a decision you made this week',
      'a place you want to revisit',
      'a skill you are learning',
      'a disagreement you handled calmly',
      'a story from your childhood',
      'a useful word you discovered',
    ];

    for (final topic in catalog) {
      if (avoided.contains(topic) || recent.contains(topic)) continue;
      return CoachedRecommendation(
        value: topic,
        reasons: [
          const RecommendationReason(
            code: 'fresh_topic',
            message:
                'Suggest a fresh topic that avoids recent and avoided subjects.',
          ),
          if (context.profile.weakestSkillIds.isNotEmpty)
            const RecommendationReason(
              code: 'supports_weak_skill',
              message: 'Topic supports work on a weak skill.',
            ),
        ],
        confidence: 0.75,
      );
    }

    return const CoachedRecommendation(
      value: 'something meaningful from your day',
      reasons: [
        RecommendationReason(
          code: 'fallback_topic',
          message: 'Fallback open topic for natural conversation practice.',
        ),
      ],
      confidence: 0.55,
    );
  }

  CoachedRecommendation<int> recommendSpeakingSeconds(LearnerContext context) {
    final recent = context.recentSessions
        .where((session) => session.speakingSeconds > 0)
        .take(5)
        .toList();
    if (recent.isEmpty) {
      return const CoachedRecommendation(
        value: 90,
        reasons: [
          RecommendationReason(
            code: 'default_duration',
            message: 'Default speaking target: 90 seconds for a focused turn.',
          ),
        ],
      );
    }

    final avg = recent
            .map((session) => session.speakingSeconds)
            .reduce((a, b) => a + b) ~/
        recent.length;

    if (_speakingDurationDecreasing(context)) {
      final target = (avg + 30).clamp(90, 240);
      return CoachedRecommendation(
        value: target,
        reasons: [
          RecommendationReason(
            code: 'rebuild_endurance',
            message:
                'Speaking duration is trending down — aim for $target seconds.',
          ),
        ],
        confidence: 0.8,
      );
    }

    final target = avg.clamp(60, 180);
    return CoachedRecommendation(
      value: target,
      reasons: [
        RecommendationReason(
          code: 'match_recent_pace',
          message: 'Match recent average speaking length ($avg seconds).',
        ),
      ],
      confidence: 0.7,
    );
  }

  List<Expression> reviewWords(LearnerContext context, {int limit = 8}) {
    final now = context.asOf;
    final due = context.expressions.where((item) {
      if (item.nextReviewAt == null) return true;
      return !item.nextReviewAt!.isAfter(now);
    }).toList()
      ..sort((a, b) {
        final aAt = a.nextReviewAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bAt = b.nextReviewAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return aAt.compareTo(bAt);
      });
    return due.take(limit).toList();
  }

  List<Expression> practiceExpressions(
    LearnerContext context, {
    int limit = 5,
  }) {
    final learning = context.expressions
        .where(
          (item) =>
              item.strength == MemoryStrength.learning ||
              item.strength == MemoryStrength.newItem ||
              item.strength == MemoryStrength.reviewing,
        )
        .toList();
    return learning.take(limit).toList();
  }

  ({String skillId, String title, int daysSince})? findNeglectedSkill(
    LearnerContext context, {
    int thresholdDays = 10,
  }) {
    final lastBySkill = <String, DateTime>{};
    for (final entry in context.exerciseHistory) {
      final existing = lastBySkill[entry.primarySkillId];
      if (existing == null || entry.completedAt.isAfter(existing)) {
        lastBySkill[entry.primarySkillId] = entry.completedAt;
      }
    }

    ({String skillId, String title, int daysSince})? worst;
    for (final skill in context.skills.where((item) => !item.isFuture)) {
      final last = lastBySkill[skill.id];
      // Only previously practiced skills count as "neglected".
      if (last == null) continue;
      final days = KompasDateUtils.calendarDaysBetween(last, context.asOf);
      if (days < thresholdDays) continue;
      if (worst == null || days > worst.daysSince) {
        worst = (skillId: skill.id, title: skill.title, daysSince: days);
      }
    }
    return worst;
  }

  bool _isModeDominant(
    LearnerContext context,
    PracticeMode mode, {
    required double ratio,
  }) {
    final recent = context.exerciseHistory.take(10).toList();
    if (recent.length < 4) return false;
    final count = recent.where((entry) => entry.mode == mode).length;
    return count / recent.length >= ratio;
  }

  bool _speakingDurationDecreasing(LearnerContext context) {
    final samples = context.recentSessions
        .where((session) => session.speakingSeconds > 0)
        .take(6)
        .map((session) => session.speakingSeconds)
        .toList();
    if (samples.length < 4) return false;
    final newer = samples.take(2).fold<int>(0, (a, b) => a + b) / 2;
    final older = samples.skip(2).take(2).fold<int>(0, (a, b) => a + b) / 2;
    return newer < older * 0.85;
  }

  int daysSinceMode(LearnerContext context, PracticeMode mode) {
    for (final entry in context.exerciseHistory) {
      if (entry.mode == mode) {
        return KompasDateUtils.calendarDaysBetween(
          entry.completedAt,
          context.asOf,
        );
      }
    }
    return 999;
  }
}
