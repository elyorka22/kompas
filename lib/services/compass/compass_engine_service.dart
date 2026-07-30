import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/utils/date_utils.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/completed_exercise_result.dart';
import 'package:kompas/domain/entities/conversation_message.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/daily_completion.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/entities/daily_plan.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';
import 'package:kompas/domain/entities/finished_session_result.dart';
import 'package:kompas/domain/entities/learning_path.dart';
import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/domain/enums/goal_enums.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/domain/enums/skill_enums.dart';
import 'package:kompas/domain/repositories/conversation_repository.dart';
import 'package:kompas/domain/repositories/daily_plan_repository.dart';
import 'package:kompas/domain/repositories/exercise_history_repository.dart';
import 'package:kompas/domain/repositories/mission_repository.dart';
import 'package:kompas/domain/repositories/skill_repository.dart';
import 'package:kompas/domain/repositories/statistics_repository.dart';
import 'package:kompas/services/compass/exercise_rotator.dart';
import 'package:kompas/services/compass/practice_mode_catalog.dart';
import 'package:kompas/services/compass/skill_xp_rules.dart';
import 'package:kompas/services/progress/progress_calculator_service.dart';
import 'package:kompas/shared/catalog/default_exercise_catalog.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

/// Compass Engine v1 — offline learning brain.
///
/// Creates sessions, daily plans, missions, exercise recommendations,
/// skill progress and streaks. No AI. No backend.
class CompassEngineService {
  CompassEngineService({
    required ConversationRepository conversationRepository,
    required MissionRepository missionRepository,
    required SkillRepository skillRepository,
    required SkillProgressRepository skillProgressRepository,
    required LearningPathRepository learningPathRepository,
    required StatisticsRepository statisticsRepository,
    required ExerciseHistoryRepository exerciseHistoryRepository,
    required DailyPlanRepository dailyPlanRepository,
    ProgressCalculatorService? progressCalculator,
    ExerciseRotator? exerciseRotator,
    List<Exercise>? exerciseCatalog,
    List<Skill>? skillCatalog,
    DateTime Function()? clock,
    int Function(int max)? randomIndex,
  })  : _conversations = conversationRepository,
        _missions = missionRepository,
        _skills = skillRepository,
        _skillProgress = skillProgressRepository,
        _learningPaths = learningPathRepository,
        _statistics = statisticsRepository,
        _history = exerciseHistoryRepository,
        _dailyPlans = dailyPlanRepository,
        _progress = progressCalculator ?? ProgressCalculatorService(),
        _rotator = exerciseRotator ??
            const ExerciseRotator(
              recentBlockSize: AppConstants.exerciseRepeatBlockSize,
            ),
        _exercises = exerciseCatalog ?? DefaultExerciseCatalog.exercises,
        _skillCatalog = skillCatalog ?? DefaultSkillCatalog.skills,
        _clock = clock ?? (() => DateTime.now().toUtc()),
        _randomIndex = randomIndex;

  final ConversationRepository _conversations;
  final MissionRepository _missions;
  final SkillRepository _skills;
  final SkillProgressRepository _skillProgress;
  final LearningPathRepository _learningPaths;
  final StatisticsRepository _statistics;
  final ExerciseHistoryRepository _history;
  final DailyPlanRepository _dailyPlans;
  final ProgressCalculatorService _progress;
  final ExerciseRotator _rotator;
  final List<Exercise> _exercises;
  final List<Skill> _skillCatalog;
  final DateTime Function() _clock;
  final int Function(int max)? _randomIndex;

  // ── Sessions ────────────────────────────────────────────────────────────

  Future<Result<ConversationSession>> startSession({
    required String userId,
    PracticeMode? mode,
    String? exerciseId,
    String? title,
    String? prompt,
    String? targetSkillId,
  }) async {
    final now = _clock();
    final focusSkillId = targetSkillId ?? await _resolveFocusSkillId(userId);

    final Exercise? exercise = exerciseId != null
        ? _findExercise(exerciseId)
        : (await recommendNextExercise(
            userId: userId,
            preferredMode: mode,
            focusSkillId: focusSkillId,
          ))
            .valueOrNull;

    if (exerciseId != null && exercise == null) {
      return const Err(NotFoundFailure('Exercise not found'));
    }

    final resolvedMode = mode ?? exercise?.mode ?? PracticeMode.tellAboutDay;
    final resolvedSkillId = targetSkillId ??
        exercise?.primarySkillId ??
        PracticeModeCatalog.primarySkillId(resolvedMode);
    final resolvedPrompt = prompt ??
        exercise?.prompt ??
        PracticeModeCatalog.defaultPrompt(resolvedMode);
    final resolvedTitle =
        title ?? exercise?.title ?? PracticeModeCatalog.title(resolvedMode);

    final session = ConversationSession(
      id: IdGenerator.v4(),
      userId: userId,
      mode: resolvedMode,
      status: SessionStatus.active,
      title: resolvedTitle,
      prompt: resolvedPrompt,
      targetSkillId: resolvedSkillId,
      currentExerciseId: exercise?.id,
      startedAt: now,
      createdAt: now,
      updatedAt: now,
    );

    final created = await _conversations.createSession(session);
    if (created.isFailure) return created;

    final coach = ConversationMessage(
      id: IdGenerator.v4(),
      sessionId: session.id,
      role: MessageRole.coach,
      content: resolvedPrompt,
      createdAt: now,
    );
    await _conversations.addMessage(coach);

    return Success(session);
  }

  Future<Result<FinishedSessionResult>> finishSession({
    required ConversationSession session,
    required int speakingSeconds,
  }) async {
    final now = _clock();
    final completed = session.copyWith(
      status: SessionStatus.completed,
      speakingSeconds: speakingSeconds,
      endedAt: now,
      updatedAt: now,
    );
    final saved = await _conversations.updateSession(completed);
    if (saved.isFailure) {
      return Err(saved.failureOrNull!);
    }

    final statsResult = await _statistics.getOrCreate(session.userId);
    if (statsResult.isFailure) {
      return Err(statsResult.failureOrNull!);
    }

    var stats = _progress.afterSpeaking(
      current: statsResult.valueOrNull!,
      speakingSeconds: speakingSeconds,
      sessionCompleted: true,
      now: now,
    );

    final skillId =
        session.targetSkillId ?? PracticeModeCatalog.primarySkillId(session.mode);
    final skillUpdates = await updateSkillProgress(
      userId: session.userId,
      skillId: skillId,
      xpGain: SkillXpRules.sessionFinishXp,
    );
    final updatedSkills = <SkillProgress>[];
    if (skillUpdates.isSuccess) {
      updatedSkills.add(skillUpdates.valueOrNull!);
      final skill = DefaultSkillCatalog.byId(skillId);
      if (skill != null &&
          skillUpdates.valueOrNull!.status == SkillStatus.mastered) {
        stats = _progress.afterSkillMastered(stats);
      }
    }

    await _bumpCompleteSessionMission(session.userId, now);
    await _bumpSpeakMinutesMission(session.userId, speakingSeconds, now);

    final savedStats = await _statistics.save(stats);
    if (savedStats.isFailure) {
      return Err(savedStats.failureOrNull!);
    }

    await _advanceLearningPathIfNeeded(session.userId, updatedSkills);

    return Success(
      FinishedSessionResult(
        session: completed,
        statistics: savedStats.valueOrNull!,
        updatedSkills: updatedSkills,
        streakDays: savedStats.valueOrNull!.currentStreakDays,
      ),
    );
  }

  // ── Missions & daily plan ─────────────────────────────────────────────

  Future<Result<DailyMission>> generateDailyMission({
    required String userId,
    DateTime? date,
    String? focusSkillId,
  }) async {
    final plan = await generateDailyPlan(
      userId: userId,
      date: date,
      focusSkillId: focusSkillId,
    );
    if (plan.isFailure) return Err(plan.failureOrNull!);

    final primaryId = plan.valueOrNull!.primaryMissionId;
    final missions = await _missions.listForDay(
      userId: userId,
      dayKey: plan.valueOrNull!.dayKey,
    );
    if (missions.isFailure) return Err(missions.failureOrNull!);

    final list = missions.valueOrNull!;
    if (list.isEmpty) {
      return const Err(NotFoundFailure('No daily mission generated'));
    }

    for (final mission in list) {
      if (mission.id == primaryId) return Success(mission);
    }
    return Success(list.first);
  }

  Future<Result<DailyPlan>> generateDailyPlan({
    required String userId,
    DateTime? date,
    String? focusSkillId,
  }) async {
    final now = _clock();
    final day = date ?? now;
    final dayKey = KompasDateUtils.dayKey(day);

    final existing = await _dailyPlans.getForDay(userId: userId, dayKey: dayKey);
    if (existing.isFailure) return Err(existing.failureOrNull!);
    if (existing.valueOrNull != null) {
      return Success(existing.valueOrNull!);
    }

    final resolvedFocus =
        focusSkillId ?? await _resolveFocusSkillId(userId);
    final preferredModes = _preferredModesForFocus(resolvedFocus);

    final existingMissions =
        await _missions.listForDay(userId: userId, dayKey: dayKey);
    if (existingMissions.isFailure) {
      return Err(existingMissions.failureOrNull!);
    }

    var missions = existingMissions.valueOrNull!;
    if (missions.isEmpty) {
      missions = _buildMissions(
        userId: userId,
        dayKey: dayKey,
        focusSkillId: resolvedFocus,
        now: now,
      );
      final saved = await _missions.saveAll(missions);
      if (saved.isFailure) return Err(saved.failureOrNull!);
    }

    final recommendedIds = <String>[];
    final history = await _history.listRecent(userId: userId, limit: 30);
    final historyList = history.valueOrNull ?? const <ExerciseHistoryEntry>[];

    for (var i = 0; i < AppConstants.dailyPlanExerciseCount; i++) {
      final preferred =
          preferredModes.isEmpty ? null : preferredModes[i % preferredModes.length];
      final syntheticHistory = [
        ...recommendedIds.map(
          (id) => ExerciseHistoryEntry(
            id: 'plan_$id',
            userId: userId,
            exerciseId: id,
            mode: _findExercise(id)?.mode ?? PracticeMode.tellAboutDay,
            primarySkillId:
                _findExercise(id)?.primarySkillId ?? SkillIds.conversation,
            completedAt: now,
          ),
        ),
        ...historyList,
      ];
      final next = _rotator.recommend(
        candidates: _exercises,
        historyNewestFirst: syntheticHistory,
        preferredMode: preferred,
        focusSkillId: resolvedFocus,
        pickIndex: _randomIndex,
      );
      if (next == null) break;
      recommendedIds.add(next.id);
    }

    final plan = DailyPlan(
      id: IdGenerator.v4(),
      userId: userId,
      dayKey: dayKey,
      missionIds: missions.map((mission) => mission.id).toList(),
      recommendedExerciseIds: recommendedIds,
      preferredModes: preferredModes,
      focusSkillId: resolvedFocus,
      primaryMissionId: missions.first.id,
      createdAt: now,
    );

    return _dailyPlans.save(plan);
  }

  // ── Exercises ─────────────────────────────────────────────────────────

  Future<Result<Exercise>> recommendNextExercise({
    required String userId,
    PracticeMode? preferredMode,
    String? focusSkillId,
  }) async {
    final history = await _history.listRecent(userId: userId, limit: 30);
    if (history.isFailure) return Err(history.failureOrNull!);

    final focus = focusSkillId ?? await _resolveFocusSkillId(userId);
    final mode = preferredMode ??
        (_preferredModesForFocus(focus).isEmpty
            ? null
            : _preferredModesForFocus(focus).first);

    final candidates = preferredMode == null
        ? _exercises
        : _exercises.where((exercise) => exercise.mode == preferredMode).toList();

    final pick = _rotator.recommend(
      candidates: candidates.isEmpty ? _exercises : candidates,
      historyNewestFirst: history.valueOrNull!,
      preferredMode: mode,
      focusSkillId: focus,
      pickIndex: _randomIndex,
    );

    if (pick == null) {
      return const Err(NotFoundFailure('No exercise available'));
    }
    return Success(pick);
  }

  Future<Result<CompletedExerciseResult>> completeExercise({
    required String userId,
    required String exerciseId,
    String? sessionId,
  }) async {
    final exercise = _findExercise(exerciseId);
    if (exercise == null) {
      return const Err(NotFoundFailure('Exercise not found'));
    }

    final now = _clock();
    final xpTotal =
        SkillXpRules.primaryExerciseXp +
        (exercise.secondarySkillIds.isEmpty
            ? 0
            : SkillXpRules.secondaryExerciseXp *
                exercise.secondarySkillIds.length.clamp(0, 2));

    final entry = ExerciseHistoryEntry(
      id: IdGenerator.v4(),
      userId: userId,
      exerciseId: exercise.id,
      sessionId: sessionId,
      mode: exercise.mode,
      primarySkillId: exercise.primarySkillId,
      xpEarned: xpTotal,
      completedAt: now,
    );
    final savedHistory = await _history.save(entry);
    if (savedHistory.isFailure) {
      return Err(savedHistory.failureOrNull!);
    }

    final updatedSkills = <SkillProgress>[];
    final primary = await updateSkillProgress(
      userId: userId,
      skillId: exercise.primarySkillId,
      xpGain: SkillXpRules.primaryExerciseXp,
    );
    if (primary.isFailure) return Err(primary.failureOrNull!);
    updatedSkills.add(primary.valueOrNull!);

    for (final secondaryId in exercise.secondarySkillIds.take(2)) {
      final secondary = await updateSkillProgress(
        userId: userId,
        skillId: secondaryId,
        xpGain: SkillXpRules.secondaryExerciseXp,
      );
      if (secondary.isSuccess) {
        updatedSkills.add(secondary.valueOrNull!);
      }
    }

    if (sessionId != null) {
      final sessionResult = await _conversations.getSession(sessionId);
      if (sessionResult.isSuccess) {
        final session = sessionResult.valueOrNull!;
        await _conversations.updateSession(
          session.copyWith(
            exercisesCompleted: session.exercisesCompleted + 1,
            currentExerciseId: exercise.id,
            updatedAt: now,
          ),
        );
      }
    }

    await _bumpPracticeSkillMission(userId, exercise.primarySkillId, now);

    return Success(
      CompletedExerciseResult(
        exercise: exercise,
        historyEntry: entry,
        updatedSkills: updatedSkills,
      ),
    );
  }

  // ── Skills ────────────────────────────────────────────────────────────

  Future<Result<SkillProgress>> updateSkillProgress({
    required String userId,
    required String skillId,
    required int xpGain,
  }) async {
    Skill? skill;
    for (final item in _skillCatalog) {
      if (item.id == skillId) {
        skill = item;
        break;
      }
    }
    skill ??= DefaultSkillCatalog.byId(skillId);
    if (skill == null) {
      return const Err(NotFoundFailure('Skill not found'));
    }
    if (skill.isFuture) {
      return const Err(
        UnsupportedFailure('This skill is not available in Compass Engine v1'),
      );
    }

    await _skills.seedIfEmpty(_skillCatalog);

    final now = _clock();
    final existingList = await _skillProgress.listByUser(userId);
    if (existingList.isFailure) return Err(existingList.failureOrNull!);

    final bySkillId = <String, SkillProgress>{
      for (final item in existingList.valueOrNull!) item.skillId: item,
    };

    final current = SkillXpRules.initialFor(
      userId: userId,
      skill: skill,
      bySkillId: bySkillId,
      now: now,
    );

    if (current.status == SkillStatus.locked &&
        !_prerequisitesMastered(skill, bySkillId)) {
      return const Err(
        ValidationFailure('Skill is locked until prerequisites are mastered'),
      );
    }

    final available = current.status == SkillStatus.locked
        ? current.copyWith(status: SkillStatus.available, updatedAt: now)
        : current;

    final updated = SkillXpRules.applyXp(
      progress: available,
      skill: skill,
      xpGain: xpGain,
      now: now,
    );
    bySkillId[skill.id] = updated;

    final unlocks = SkillXpRules.refreshUnlocks(
      userId: userId,
      skills: _skillCatalog,
      bySkillId: bySkillId,
      now: now,
    );

    final saved = await _skillProgress.save(updated);
    if (saved.isFailure) return saved;

    for (final unlock in unlocks) {
      if (unlock.skillId == updated.skillId) continue;
      await _skillProgress.save(unlock);
    }

    return saved;
  }

  // ── Metrics ───────────────────────────────────────────────────────────

  Future<Result<int>> calculateStreak({required String userId}) async {
    final stats = await _statistics.getOrCreate(userId);
    if (stats.isFailure) return Err(stats.failureOrNull!);
    final streak = _progress.calculateStreak(
      current: stats.valueOrNull!,
      now: _clock(),
    );
    return Success(streak.current);
  }

  Future<Result<DailyCompletion>> calculateDailyCompletion({
    required String userId,
    DateTime? date,
  }) async {
    final day = date ?? _clock();
    final dayKey = KompasDateUtils.dayKey(day);
    final missions = await _missions.listForDay(userId: userId, dayKey: dayKey);
    if (missions.isFailure) return Err(missions.failureOrNull!);

    final list = missions.valueOrNull!;
    if (list.isEmpty) {
      return Success(
        DailyCompletion(
          dayKey: dayKey,
          totalMissions: 0,
          completedMissions: 0,
          ratio: 0,
          isComplete: false,
        ),
      );
    }

    final completed =
        list.where((mission) => mission.status == MissionStatus.completed).length;
    final ratio = completed / list.length;
    return Success(
      DailyCompletion(
        dayKey: dayKey,
        totalMissions: list.length,
        completedMissions: completed,
        ratio: ratio,
        isComplete: completed == list.length,
      ),
    );
  }

  // ── Internals ─────────────────────────────────────────────────────────

  Exercise? _findExercise(String id) {
    for (final exercise in _exercises) {
      if (exercise.id == id) return exercise;
    }
    return null;
  }

  bool _prerequisitesMastered(
    Skill skill,
    Map<String, SkillProgress> bySkillId,
  ) {
    for (final prerequisiteId in skill.prerequisiteSkillIds) {
      final progress = bySkillId[prerequisiteId];
      if (progress == null || progress.status != SkillStatus.mastered) {
        return false;
      }
    }
    return true;
  }

  Future<String?> _resolveFocusSkillId(String userId) async {
    final userPath = await _learningPaths.getUserPath(userId);
    if (userPath.isSuccess && userPath.valueOrNull?.currentSkillId != null) {
      return userPath.valueOrNull!.currentSkillId;
    }

    final defaultPath = await _learningPaths.getDefault();
    final path = defaultPath.valueOrNull;
    if (path == null || path.skillIds.isEmpty) {
      return SkillIds.conversation;
    }

    final progressList = await _skillProgress.listByUser(userId);
    final bySkill = <String, SkillProgress>{
      for (final item in progressList.valueOrNull ?? const <SkillProgress>[])
        item.skillId: item,
    };

    for (final skillId in path.skillIds) {
      final progress = bySkill[skillId];
      if (progress == null || progress.status != SkillStatus.mastered) {
        return skillId;
      }
    }
    return path.skillIds.last;
  }

  List<PracticeMode> _preferredModesForFocus(String? focusSkillId) {
    if (focusSkillId == null) {
      return [
        PracticeMode.tellAboutDay,
        PracticeMode.explainWord,
        PracticeMode.continueStory,
      ];
    }
    final matched = PracticeModeCatalog.modesForSkill(focusSkillId);
    if (matched.isNotEmpty) return matched;
    return [PracticeMode.tellAboutDay];
  }

  List<DailyMission> _buildMissions({
    required String userId,
    required String dayKey,
    required String? focusSkillId,
    required DateTime now,
  }) {
    return [
      DailyMission(
        id: IdGenerator.v4(),
        userId: userId,
        type: MissionType.completeSession,
        status: MissionStatus.pending,
        title: 'Complete a practice session',
        description: 'Finish one Compass speaking session today.',
        targetValue: 1,
        skillId: focusSkillId,
        dayKey: dayKey,
        createdAt: now,
        updatedAt: now,
      ),
      DailyMission(
        id: IdGenerator.v4(),
        userId: userId,
        type: MissionType.speakMinutes,
        status: MissionStatus.pending,
        title: 'Speak today',
        description:
            'Accumulate ${AppConstants.defaultDailySpeakingMinutes} minutes of speaking.',
        targetValue: AppConstants.defaultDailySpeakingMinutes,
        dayKey: dayKey,
        createdAt: now,
        updatedAt: now,
      ),
      DailyMission(
        id: IdGenerator.v4(),
        userId: userId,
        type: MissionType.practiceSkill,
        status: MissionStatus.pending,
        title: 'Train your focus skill',
        description: 'Complete an exercise for your current Skill Tree focus.',
        targetValue: 1,
        skillId: focusSkillId,
        dayKey: dayKey,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  Future<void> _bumpCompleteSessionMission(String userId, DateTime now) async {
    final dayKey = KompasDateUtils.dayKey(now);
    final missions = await _missions.listForDay(userId: userId, dayKey: dayKey);
    if (missions.isFailure) return;
    for (final mission in missions.valueOrNull!) {
      if (mission.type != MissionType.completeSession) continue;
      if (mission.status == MissionStatus.completed) continue;
      final nextValue = mission.currentValue + 1;
      final done = nextValue >= mission.targetValue;
      await _missions.update(
        mission.copyWith(
          currentValue: nextValue,
          status: done ? MissionStatus.completed : MissionStatus.inProgress,
          completedAt: done ? now : null,
          updatedAt: now,
        ),
      );
      if (done) {
        final stats = await _statistics.getOrCreate(userId);
        if (stats.isSuccess) {
          await _statistics.save(
            _progress.afterMissionCompleted(stats.valueOrNull!),
          );
        }
      }
    }
  }

  Future<void> _bumpSpeakMinutesMission(
    String userId,
    int speakingSeconds,
    DateTime now,
  ) async {
    final minutes = (speakingSeconds / 60).ceil();
    if (minutes <= 0) return;
    final dayKey = KompasDateUtils.dayKey(now);
    final missions = await _missions.listForDay(userId: userId, dayKey: dayKey);
    if (missions.isFailure) return;
    for (final mission in missions.valueOrNull!) {
      if (mission.type != MissionType.speakMinutes) continue;
      if (mission.status == MissionStatus.completed) continue;
      final nextValue = mission.currentValue + minutes;
      final done = nextValue >= mission.targetValue;
      await _missions.update(
        mission.copyWith(
          currentValue: nextValue,
          status: done ? MissionStatus.completed : MissionStatus.inProgress,
          completedAt: done ? now : null,
          updatedAt: now,
        ),
      );
    }
  }

  Future<void> _bumpPracticeSkillMission(
    String userId,
    String skillId,
    DateTime now,
  ) async {
    final dayKey = KompasDateUtils.dayKey(now);
    final missions = await _missions.listForDay(userId: userId, dayKey: dayKey);
    if (missions.isFailure) return;
    for (final mission in missions.valueOrNull!) {
      if (mission.type != MissionType.practiceSkill) continue;
      if (mission.status == MissionStatus.completed) continue;
      if (mission.skillId != null && mission.skillId != skillId) continue;
      final nextValue = mission.currentValue + 1;
      final done = nextValue >= mission.targetValue;
      await _missions.update(
        mission.copyWith(
          currentValue: nextValue,
          status: done ? MissionStatus.completed : MissionStatus.inProgress,
          completedAt: done ? now : null,
          updatedAt: now,
        ),
      );
    }
  }

  Future<void> _advanceLearningPathIfNeeded(
    String userId,
    List<SkillProgress> updatedSkills,
  ) async {
    final mastered = updatedSkills
        .where((progress) => progress.status == SkillStatus.mastered)
        .map((progress) => progress.skillId)
        .toSet();
    if (mastered.isEmpty) return;

    final pathResult = await _learningPaths.getDefault();
    final path = pathResult.valueOrNull;
    if (path == null) return;

    final focus = await _resolveFocusSkillId(userId);
    final existing = await _learningPaths.getUserPath(userId);
    final now = _clock();
    if (existing.valueOrNull == null) {
      await _learningPaths.saveUserPath(
        UserLearningPath(
          id: IdGenerator.v4(),
          userId: userId,
          learningPathId: path.id,
          currentSkillId: focus,
          startedAt: now,
        ),
      );
      return;
    }

    final current = existing.valueOrNull!;
    if (current.currentSkillId != focus) {
      await _learningPaths.saveUserPath(
        current.copyWith(currentSkillId: focus),
      );
    }
  }
}
