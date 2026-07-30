import 'package:flutter_test/flutter_test.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';
import 'package:kompas/domain/enums/goal_enums.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/domain/enums/skill_enums.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';
import 'package:kompas/services/compass/exercise_rotator.dart';
import 'package:kompas/shared/catalog/default_exercise_catalog.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

import 'helpers/in_memory_repos.dart';

CompassEngineService buildEngine(CompassEngineServiceDeps deps) {
  return CompassEngineService(
    conversationRepository: deps.conversations,
    missionRepository: deps.missions,
    skillRepository: deps.skills,
    skillProgressRepository: deps.progress,
    learningPathRepository: deps.paths,
    statisticsRepository: deps.stats,
    exerciseHistoryRepository: deps.history,
    dailyPlanRepository: deps.plans,
    clock: deps.clock,
    randomIndex: deps.randomIndex ?? ((_) => 0),
  );
}

ExerciseHistoryEntry historyEntry({
  required String exerciseId,
  required PracticeMode mode,
  required String skillId,
}) {
  return ExerciseHistoryEntry(
    id: 'h_$exerciseId',
    userId: 'user_1',
    exerciseId: exerciseId,
    mode: mode,
    primarySkillId: skillId,
    completedAt: DateTime.utc(2026, 7, 30),
  );
}

void main() {
  group('ExerciseRotator', () {
    test('blocks recently completed exercises when alternatives exist', () {
      const rotator = ExerciseRotator(recentBlockSize: 2);
      final candidates =
          DefaultExerciseCatalog.byMode(PracticeMode.explainWord);
      final history = [
        for (final exercise in candidates.take(2))
          historyEntry(
            exerciseId: exercise.id,
            mode: PracticeMode.explainWord,
            skillId: exercise.primarySkillId,
          ),
      ];

      final pick = rotator.recommend(
        candidates: candidates,
        historyNewestFirst: history,
        preferredMode: PracticeMode.explainWord,
      );

      expect(pick, isNotNull);
      expect(
        history.map((item) => item.exerciseId),
        isNot(contains(pick!.id)),
      );
    });
  });

  group('CompassEngineService', () {
    late CompassEngineServiceDeps deps;
    late CompassEngineService engine;
    final fixedNow = DateTime.utc(2026, 7, 30, 12);

    setUp(() {
      deps = buildEngineDeps(clock: () => fixedNow);
      engine = buildEngine(deps);
    });

    test('startSession creates active session with coach prompt', () async {
      final result = await engine.startSession(
        userId: 'user_1',
        mode: PracticeMode.tellAboutDay,
      );

      expect(result.isSuccess, isTrue);
      final session = result.valueOrNull!;
      expect(session.status, SessionStatus.active);
      expect(session.mode, PracticeMode.tellAboutDay);
      expect(session.prompt, isNotEmpty);
      expect(session.currentExerciseId, isNotNull);
      expect(deps.conversations.messages[session.id], hasLength(1));
    });

    test('recommendNextExercise avoids the last completed exercise', () async {
      final first = (await engine.recommendNextExercise(
        userId: 'user_1',
        preferredMode: PracticeMode.explainWord,
      ))
          .valueOrNull!;
      await engine.completeExercise(userId: 'user_1', exerciseId: first.id);

      final next = (await engine.recommendNextExercise(
        userId: 'user_1',
        preferredMode: PracticeMode.explainWord,
      ))
          .valueOrNull!;

      expect(next.id, isNot(equals(first.id)));
      expect(next.mode, PracticeMode.explainWord);
    });

    test('completeExercise awards primary skill XP', () async {
      final exercise =
          DefaultExerciseCatalog.byMode(PracticeMode.tellAboutDay).first;
      final result = await engine.completeExercise(
        userId: 'user_1',
        exerciseId: exercise.id,
      );

      expect(result.isSuccess, isTrue);
      final primary = result.valueOrNull!.updatedSkills.firstWhere(
        (progress) => progress.skillId == exercise.primarySkillId,
      );
      expect(primary.xp, greaterThanOrEqualTo(20));
      expect(primary.status, SkillStatus.inProgress);
    });

    test('updateSkillProgress rejects locked skill', () async {
      final result = await engine.updateSkillProgress(
        userId: 'user_1',
        skillId: SkillIds.idioms,
        xpGain: 10,
      );
      expect(result.isFailure, isTrue);
    });

    test('updateSkillProgress rejects future skills', () async {
      final result = await engine.updateSkillProgress(
        userId: 'user_1',
        skillId: SkillIds.listening,
        xpGain: 10,
      );
      expect(result.isFailure, isTrue);
    });

    test('generateDailyPlan creates missions and exercise queue', () async {
      final plan = await engine.generateDailyPlan(userId: 'user_1');
      expect(plan.isSuccess, isTrue);
      expect(plan.valueOrNull!.missionIds, hasLength(3));
      expect(plan.valueOrNull!.recommendedExerciseIds, hasLength(4));
      expect(plan.valueOrNull!.recommendedExerciseIds.toSet(), hasLength(4));

      final again = await engine.generateDailyPlan(userId: 'user_1');
      expect(again.valueOrNull!.id, plan.valueOrNull!.id);
    });

    test('generateDailyMission returns primary mission', () async {
      final mission = await engine.generateDailyMission(userId: 'user_1');
      expect(mission.isSuccess, isTrue);
      expect(mission.valueOrNull!.type, MissionType.completeSession);
    });

    test('finishSession updates stats streak and missions', () async {
      final session = (await engine.startSession(
        userId: 'user_1',
        mode: PracticeMode.defendOpinion,
      ))
          .valueOrNull!;
      await engine.generateDailyPlan(userId: 'user_1');

      final finished = await engine.finishSession(
        session: session,
        speakingSeconds: 180,
      );

      expect(finished.isSuccess, isTrue);
      expect(finished.valueOrNull!.session.status, SessionStatus.completed);
      expect(finished.valueOrNull!.statistics.totalSpeakingSeconds, 180);
      expect(finished.valueOrNull!.streakDays, 1);

      final completion =
          await engine.calculateDailyCompletion(userId: 'user_1');
      expect(
        completion.valueOrNull!.completedMissions,
        greaterThanOrEqualTo(1),
      );
    });

    test('calculateStreak returns current streak days', () async {
      final session =
          (await engine.startSession(userId: 'user_1')).valueOrNull!;
      await engine.finishSession(session: session, speakingSeconds: 60);
      final streak = await engine.calculateStreak(userId: 'user_1');
      expect(streak.valueOrNull, 1);
    });

    test('calculateDailyCompletion reports ratio', () async {
      await engine.generateDailyPlan(userId: 'user_1');
      final before = await engine.calculateDailyCompletion(userId: 'user_1');
      expect(before.valueOrNull!.ratio, 0);

      final session =
          (await engine.startSession(userId: 'user_1')).valueOrNull!;
      await engine.finishSession(session: session, speakingSeconds: 600);

      final after = await engine.calculateDailyCompletion(userId: 'user_1');
      expect(after.valueOrNull!.completedMissions, greaterThan(0));
      expect(after.valueOrNull!.ratio, greaterThan(0));
    });
  });
}
