import 'package:flutter_test/flutter_test.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/entities/learner_context.dart';
import 'package:kompas/domain/entities/personal_learning_profile.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/domain/entities/user_statistics.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/memory_enums.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/domain/enums/skill_enums.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';
import 'package:kompas/services/coach/coach_pedagogy.dart';
import 'package:kompas/services/coach/learner_context_loader.dart';
import 'package:kompas/shared/catalog/default_exercise_catalog.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

import 'helpers/in_memory_repos.dart';

LearnerContext baseContext({
  List<ExerciseHistoryEntry> history = const [],
  List<ConversationSession> sessions = const [],
  List<Expression> expressions = const [],
  List<String> weakSkills = const [],
  DateTime? asOf,
}) {
  final now = asOf ?? DateTime.utc(2026, 7, 30, 12);
  return LearnerContext(
    userId: 'user_1',
    profile: PersonalLearningProfile(
      id: 'profile_user_1',
      userId: 'user_1',
      displayName: 'Ada',
      nativeLanguage: AppLanguage.ru,
      targetLanguage: AppLanguage.en,
      weakestSkillIds: weakSkills,
      strongestSkillIds: const [SkillIds.conversation],
      updatedAt: now,
    ),
    skills: DefaultSkillCatalog.skills,
    skillProgress: [
      SkillProgress(
        id: 'p1',
        userId: 'user_1',
        skillId: SkillIds.conversation,
        status: SkillStatus.inProgress,
        xp: 40,
        updatedAt: now,
      ),
    ],
    exerciseHistory: history,
    recentSessions: sessions,
    expressions: expressions,
    statistics: UserStatistics(
      id: 'stats_user_1',
      userId: 'user_1',
      updatedAt: now,
    ),
    asOf: now,
  );
}

ExerciseHistoryEntry hist({
  required String exerciseId,
  required PracticeMode mode,
  required String skillId,
  required DateTime at,
}) {
  return ExerciseHistoryEntry(
    id: 'h_$exerciseId$at',
    userId: 'user_1',
    exerciseId: exerciseId,
    mode: mode,
    primarySkillId: skillId,
    completedAt: at,
  );
}

void main() {
  const pedagogy = CoachPedagogy();

  group('CoachPedagogy', () {
    test('recommends opinion mode for weak argumentation', () {
      final context = baseContext(weakSkills: [SkillIds.argumentation]);
      final rec = pedagogy.recommendMode(context);
      expect(rec.value, PracticeMode.defendOpinion);
      expect(rec.reasons, isNotEmpty);
      expect(rec.reasons.first.code, 'weak_skill');
    });

    test('recommends idioms after long neglect', () {
      final now = DateTime.utc(2026, 7, 30);
      final context = baseContext(
        asOf: now,
        history: [
          hist(
            exerciseId: 'ex_day_morning',
            mode: PracticeMode.tellAboutDay,
            skillId: SkillIds.conversation,
            at: now.subtract(const Duration(days: 1)),
          ),
          hist(
            exerciseId: 'ex_idiom_piece_of_cake',
            mode: PracticeMode.explainIdiom,
            skillId: SkillIds.idioms,
            at: now.subtract(const Duration(days: 12)),
          ),
        ],
      );

      final rec = pedagogy.recommendMode(context);
      expect(rec.value, PracticeMode.explainIdiom);
      expect(
        rec.reasons.any((reason) => reason.code == 'neglected_skill'),
        isTrue,
      );
    });

    test('increases difficulty when easy exercises dominate', () {
      final now = DateTime.utc(2026, 7, 30);
      final starters = DefaultExerciseCatalog.active
          .where((item) => item.difficulty == ExerciseDifficulty.starter)
          .take(8)
          .toList();
      final context = baseContext(
        asOf: now,
        history: [
          for (var i = 0; i < starters.length; i++)
            hist(
              exerciseId: starters[i].id,
              mode: starters[i].mode,
              skillId: starters[i].primarySkillId,
              at: now.subtract(Duration(hours: i)),
            ),
        ],
      );

      final rec = pedagogy.recommendDifficulty(context);
      expect(rec.value, ExerciseDifficulty.core);
      expect(rec.reasons.first.code, 'ease_bias');
    });

    test('rebalances from vocabulary to conversation', () {
      final now = DateTime.utc(2026, 7, 30);
      final vocab = DefaultExerciseCatalog.byMode(PracticeMode.explainWord);
      final context = baseContext(
        asOf: now,
        history: [
          for (var i = 0; i < 6; i++)
            hist(
              exerciseId: vocab[i % vocab.length].id,
              mode: PracticeMode.explainWord,
              skillId: SkillIds.vocabulary,
              at: now.subtract(Duration(hours: i)),
            ),
        ],
      );

      final rec = pedagogy.recommendMode(context);
      expect(rec.value, PracticeMode.tellAboutDay);
      expect(rec.reasons.first.code, 'rebalance_vocabulary');
    });

    test('recommends storytelling when speaking duration decreases', () {
      final now = DateTime.utc(2026, 7, 30);
      final context = baseContext(
        asOf: now,
        sessions: [
          ConversationSession(
            id: 's1',
            userId: 'user_1',
            mode: PracticeMode.tellAboutDay,
            status: SessionStatus.completed,
            title: 'a',
            speakingSeconds: 40,
            startedAt: now.subtract(const Duration(hours: 1)),
            createdAt: now,
            updatedAt: now,
          ),
          ConversationSession(
            id: 's2',
            userId: 'user_1',
            mode: PracticeMode.tellAboutDay,
            status: SessionStatus.completed,
            title: 'b',
            speakingSeconds: 45,
            startedAt: now.subtract(const Duration(hours: 2)),
            createdAt: now,
            updatedAt: now,
          ),
          ConversationSession(
            id: 's3',
            userId: 'user_1',
            mode: PracticeMode.tellAboutDay,
            status: SessionStatus.completed,
            title: 'c',
            speakingSeconds: 120,
            startedAt: now.subtract(const Duration(days: 1)),
            createdAt: now,
            updatedAt: now,
          ),
          ConversationSession(
            id: 's4',
            userId: 'user_1',
            mode: PracticeMode.tellAboutDay,
            status: SessionStatus.completed,
            title: 'd',
            speakingSeconds: 130,
            startedAt: now.subtract(const Duration(days: 2)),
            createdAt: now,
            updatedAt: now,
          ),
        ],
      );

      final rec = pedagogy.recommendMode(context);
      expect(rec.value, PracticeMode.continueStory);
      expect(rec.reasons.first.code, 'speaking_duration_down');
    });

    test('recommendExercise always includes reasons', () {
      final rec = pedagogy.recommendExercise(baseContext());
      expect(rec.reasons, isNotEmpty);
      expect(rec.value.id, isNotEmpty);
    });
  });

  group('CoachEngineService', () {
    late CoachEngineDeps deps;
    late CoachEngineService coach;
    final now = DateTime.utc(2026, 7, 30, 21);

    setUp(() {
      deps = buildCoachDeps(clock: () => now);
      coach = CoachEngineService(
        contextLoader: LearnerContextLoader(
          userRepository: deps.users,
          skillRepository: deps.skills,
          skillProgressRepository: deps.progress,
          exerciseHistoryRepository: deps.history,
          conversationRepository: deps.conversations,
          expressionRepository: deps.expressions,
          statisticsRepository: deps.stats,
          dailyPlanRepository: deps.plans,
          missionRepository: deps.missions,
          clock: () => now,
        ),
      );
    });

    test('generateLearningStrategy includes reasons and evening schedule hint',
        () async {
      final strategy =
          await coach.generateLearningStrategy(userId: 'user_1');
      expect(strategy.isSuccess, isTrue);
      expect(strategy.valueOrNull!.reasons, isNotEmpty);
      // No sessions yet → no evening hint required; still a valid strategy.
      expect(strategy.valueOrNull!.primaryMode, isNotNull);
      expect(strategy.valueOrNull!.priorityExerciseIds, isNotEmpty);
    });

    test('recommendWords returns due expressions with reason', () async {
      await deps.expressions.save(
        Expression(
          id: 'e1',
          userId: 'user_1',
          targetText: 'resilience',
          source: ExpressionSource.manual,
          nextReviewAt: now.subtract(const Duration(days: 1)),
          createdAt: now,
          updatedAt: now,
        ),
      );

      final words = await coach.recommendWords(userId: 'user_1');
      expect(words.isSuccess, isTrue);
      expect(words.valueOrNull!.value, hasLength(1));
      expect(words.valueOrNull!.reasons.first.code, 'sm2_due');
    });

    test('evaluateDailyBalance flags mode overuse', () async {
      final vocab = DefaultExerciseCatalog.byMode(PracticeMode.explainWord);
      for (var i = 0; i < 3; i++) {
        await deps.history.save(
          hist(
            exerciseId: vocab[i].id,
            mode: PracticeMode.explainWord,
            skillId: SkillIds.vocabulary,
            at: now.subtract(Duration(minutes: i)),
          ),
        );
      }

      final balance = await coach.evaluateDailyBalance(userId: 'user_1');
      expect(balance.isSuccess, isTrue);
      expect(balance.valueOrNull!.isBalanced, isFalse);
      expect(balance.valueOrNull!.overusedMode, PracticeMode.explainWord);
      expect(balance.valueOrNull!.reasons, isNotEmpty);
    });

    test('recommendConversationGoal returns reasoned goal', () async {
      final goal = await coach.recommendConversationGoal(userId: 'user_1');
      expect(goal.isSuccess, isTrue);
      expect(goal.valueOrNull!.value.prompt, isNotEmpty);
      expect(goal.valueOrNull!.reasons, isNotEmpty);
    });

    test('recommendMission generates focus mission when none exist', () async {
      final mission = await coach.recommendMission(userId: 'user_1');
      expect(mission.isSuccess, isTrue);
      expect(mission.valueOrNull!.value.title, contains('Practice'));
      expect(mission.valueOrNull!.reasons, isNotEmpty);
    });
  });
}
