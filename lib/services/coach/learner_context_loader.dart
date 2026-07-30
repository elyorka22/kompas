import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/utils/date_utils.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';
import 'package:kompas/domain/entities/learner_context.dart';
import 'package:kompas/domain/entities/personal_learning_profile.dart';
import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/domain/enums/skill_enums.dart';
import 'package:kompas/domain/repositories/conversation_repository.dart';
import 'package:kompas/domain/repositories/daily_plan_repository.dart';
import 'package:kompas/domain/repositories/exercise_history_repository.dart';
import 'package:kompas/domain/repositories/expression_repository.dart';
import 'package:kompas/domain/repositories/mission_repository.dart';
import 'package:kompas/domain/repositories/skill_repository.dart';
import 'package:kompas/domain/repositories/statistics_repository.dart';
import 'package:kompas/domain/repositories/user_repository.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

/// Loads the learner snapshot Coach Engine needs from local repositories.
///
/// Bridges Compass/Memory data until Memory Engine owns the write path.
class LearnerContextLoader {
  LearnerContextLoader({
    required UserRepository userRepository,
    required SkillRepository skillRepository,
    required SkillProgressRepository skillProgressRepository,
    required ExerciseHistoryRepository exerciseHistoryRepository,
    required ConversationRepository conversationRepository,
    required ExpressionRepository expressionRepository,
    required StatisticsRepository statisticsRepository,
    required DailyPlanRepository dailyPlanRepository,
    required MissionRepository missionRepository,
    DateTime Function()? clock,
  })  : _users = userRepository,
        _skills = skillRepository,
        _skillProgress = skillProgressRepository,
        _history = exerciseHistoryRepository,
        _conversations = conversationRepository,
        _expressions = expressionRepository,
        _statistics = statisticsRepository,
        _dailyPlans = dailyPlanRepository,
        _missions = missionRepository,
        _clock = clock ?? (() => DateTime.now().toUtc());

  final UserRepository _users;
  final SkillRepository _skills;
  final SkillProgressRepository _skillProgress;
  final ExerciseHistoryRepository _history;
  final ConversationRepository _conversations;
  final ExpressionRepository _expressions;
  final StatisticsRepository _statistics;
  final DailyPlanRepository _dailyPlans;
  final MissionRepository _missions;
  final DateTime Function() _clock;

  Future<Result<LearnerContext>> load(String userId) async {
    var userResult = await _users.getById(userId);
    if (userResult.isFailure) {
      final active = await _users.getActiveUser();
      if (active.isFailure) return Err(active.failureOrNull!);
      final activeUser = active.valueOrNull;
      if (activeUser == null || activeUser.id != userId) {
        return const Err(NotFoundFailure('User not found'));
      }
      userResult = Success(activeUser);
    }

    final user = userResult.valueOrNull!;
    await _skills.seedIfEmpty(DefaultSkillCatalog.skills);

    final skills = await _skills.listAll();
    if (skills.isFailure) return Err(skills.failureOrNull!);

    final progress = await _skillProgress.listByUser(userId);
    if (progress.isFailure) return Err(progress.failureOrNull!);

    final history = await _history.listRecent(userId: userId, limit: 50);
    if (history.isFailure) return Err(history.failureOrNull!);

    final sessions =
        await _conversations.listSessions(userId: userId, limit: 30);
    if (sessions.isFailure) return Err(sessions.failureOrNull!);

    final expressions = await _expressions.listByUser(userId);
    if (expressions.isFailure) return Err(expressions.failureOrNull!);

    final stats = await _statistics.getOrCreate(userId);
    if (stats.isFailure) return Err(stats.failureOrNull!);

    final now = _clock();
    final dayKey = KompasDateUtils.dayKey(now);
    final plan = await _dailyPlans.getForDay(userId: userId, dayKey: dayKey);
    if (plan.isFailure) return Err(plan.failureOrNull!);

    final missions =
        await _missions.listForDay(userId: userId, dayKey: dayKey);
    if (missions.isFailure) return Err(missions.failureOrNull!);

    final weak = _rankSkills(
      skills.valueOrNull!,
      progress.valueOrNull!,
      ascendingXp: true,
    );
    final strong = _rankSkills(
      skills.valueOrNull!,
      progress.valueOrNull!,
      ascendingXp: false,
    );
    final favoriteModes = _favoriteModes(history.valueOrNull!);
    final preferredHour = _preferredHour(sessions.valueOrNull!);

    final profile = PersonalLearningProfile(
      id: 'profile_$userId',
      userId: userId,
      displayName: user.displayName,
      nativeLanguage: user.nativeLanguage,
      targetLanguage: user.targetLanguage,
      preferredPracticeMode:
          favoriteModes.isEmpty ? null : favoriteModes.first,
      weakestSkillIds: weak,
      strongestSkillIds: strong,
      updatedAt: now,
    );

    return Success(
      LearnerContext(
        userId: userId,
        profile: profile,
        skills: skills.valueOrNull!,
        skillProgress: progress.valueOrNull!,
        exerciseHistory: history.valueOrNull!,
        recentSessions: sessions.valueOrNull!,
        expressions: expressions.valueOrNull!,
        statistics: stats.valueOrNull!,
        dailyPlan: plan.valueOrNull,
        todaysMissions: missions.valueOrNull!,
        favoriteModes: favoriteModes,
        preferredLearningHour: preferredHour,
        asOf: now,
      ),
    );
  }

  List<String> _rankSkills(
    List<Skill> skills,
    List<SkillProgress> progress, {
    required bool ascendingXp,
  }) {
    final byId = <String, SkillProgress>{
      for (final item in progress) item.skillId: item,
    };
    final active = skills.where((skill) => !skill.isFuture).toList();
    active.sort((a, b) {
      final statusA = byId[a.id]?.status;
      final statusB = byId[b.id]?.status;
      final lockedA = statusA == SkillStatus.locked ||
          (statusA == null && a.prerequisiteSkillIds.isNotEmpty);
      final lockedB = statusB == SkillStatus.locked ||
          (statusB == null && b.prerequisiteSkillIds.isNotEmpty);
      if (lockedA != lockedB) return lockedA ? 1 : -1;
      final ax = byId[a.id]?.xp ?? 0;
      final bx = byId[b.id]?.xp ?? 0;
      return ascendingXp ? ax.compareTo(bx) : bx.compareTo(ax);
    });
    return active.take(3).map((skill) => skill.id).toList();
  }

  List<PracticeMode> _favoriteModes(List<ExerciseHistoryEntry> history) {
    final counts = <PracticeMode, int>{};
    for (final entry in history) {
      counts[entry.mode] = (counts[entry.mode] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.map((entry) => entry.key).toList();
  }

  int? _preferredHour(List<ConversationSession> sessions) {
    if (sessions.isEmpty) return null;
    final buckets = <int, int>{};
    for (final session in sessions) {
      final at = session.startedAt ?? session.createdAt;
      final hour = at.toLocal().hour;
      buckets[hour] = (buckets[hour] ?? 0) + 1;
    }
    final sorted = buckets.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.first.key;
  }
}
