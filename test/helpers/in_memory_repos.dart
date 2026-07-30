import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/conversation_message.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/entities/daily_plan.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/entities/learning_path.dart';
import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/domain/entities/user.dart';
import 'package:kompas/domain/entities/user_statistics.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/domain/repositories/conversation_repository.dart';
import 'package:kompas/domain/repositories/daily_plan_repository.dart';
import 'package:kompas/domain/repositories/exercise_history_repository.dart';
import 'package:kompas/domain/repositories/expression_repository.dart';
import 'package:kompas/domain/repositories/mission_repository.dart';
import 'package:kompas/domain/repositories/skill_repository.dart';
import 'package:kompas/domain/repositories/statistics_repository.dart';
import 'package:kompas/domain/repositories/user_repository.dart';
import 'package:kompas/shared/catalog/default_learning_path_catalog.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

class InMemoryConversationRepository implements ConversationRepository {
  final sessions = <String, ConversationSession>{};
  final messages = <String, List<ConversationMessage>>{};

  @override
  Future<Result<ConversationSession>> createSession(
    ConversationSession session,
  ) async {
    sessions[session.id] = session;
    return Success(session);
  }

  @override
  Future<Result<ConversationSession>> updateSession(
    ConversationSession session,
  ) async {
    sessions[session.id] = session;
    return Success(session);
  }

  @override
  Future<Result<ConversationSession>> getSession(String id) async {
    final session = sessions[id];
    if (session == null) {
      return const Err(NotFoundFailure('Session not found'));
    }
    return Success(session);
  }

  @override
  Future<Result<List<ConversationSession>>> listSessions({
    required String userId,
    SessionStatus? status,
    int limit = 50,
  }) async {
    var list = sessions.values.where((item) => item.userId == userId);
    if (status != null) {
      list = list.where((item) => item.status == status);
    }
    return Success(list.take(limit).toList());
  }

  @override
  Future<Result<ConversationMessage>> addMessage(
    ConversationMessage message,
  ) async {
    messages.putIfAbsent(message.sessionId, () => []).add(message);
    return Success(message);
  }

  @override
  Future<Result<List<ConversationMessage>>> listMessages(
    String sessionId,
  ) async {
    return Success(List.of(messages[sessionId] ?? const []));
  }

  @override
  Future<Result<void>> deleteSession(String id) async {
    sessions.remove(id);
    messages.remove(id);
    return const Success(null);
  }
}

class InMemoryMissionRepository implements MissionRepository {
  final items = <DailyMission>[];

  @override
  Future<Result<List<DailyMission>>> listForDay({
    required String userId,
    required String dayKey,
  }) async {
    return Success(
      items
          .where((item) => item.userId == userId && item.dayKey == dayKey)
          .toList(),
    );
  }

  @override
  Future<Result<DailyMission>> save(DailyMission mission) async {
    items.removeWhere((item) => item.id == mission.id);
    items.add(mission);
    return Success(mission);
  }

  @override
  Future<Result<void>> saveAll(List<DailyMission> missions) async {
    for (final mission in missions) {
      await save(mission);
    }
    return const Success(null);
  }

  @override
  Future<Result<DailyMission>> update(DailyMission mission) => save(mission);
}

class InMemorySkillRepository implements SkillRepository {
  final items = <Skill>[];

  @override
  Future<Result<List<Skill>>> listAll() async => Success(List.of(items));

  @override
  Future<Result<Skill>> getById(String id) async {
    for (final skill in items) {
      if (skill.id == id) return Success(skill);
    }
    return const Err(NotFoundFailure('Skill not found'));
  }

  @override
  Future<Result<void>> seedIfEmpty(List<Skill> skills) async {
    if (items.isEmpty) items.addAll(skills);
    return const Success(null);
  }
}

class InMemorySkillProgressRepository implements SkillProgressRepository {
  final items = <SkillProgress>[];

  @override
  Future<Result<List<SkillProgress>>> listByUser(String userId) async {
    return Success(items.where((item) => item.userId == userId).toList());
  }

  @override
  Future<Result<SkillProgress?>> getForSkill({
    required String userId,
    required String skillId,
  }) async {
    for (final item in items) {
      if (item.userId == userId && item.skillId == skillId) {
        return Success(item);
      }
    }
    return const Success(null);
  }

  @override
  Future<Result<SkillProgress>> save(SkillProgress progress) async {
    items.removeWhere((item) => item.id == progress.id);
    items.add(progress);
    return Success(progress);
  }
}

class InMemoryLearningPathRepository implements LearningPathRepository {
  final paths = List<LearningPath>.from(DefaultLearningPathCatalog.paths);
  UserLearningPath? userPath;

  @override
  Future<Result<List<LearningPath>>> listAll() async => Success(List.of(paths));

  @override
  Future<Result<LearningPath?>> getDefault() async {
    for (final path in paths) {
      if (path.isDefault) return Success(path);
    }
    return const Success(null);
  }

  @override
  Future<Result<UserLearningPath?>> getUserPath(String userId) async {
    if (userPath?.userId == userId) return Success(userPath);
    return const Success(null);
  }

  @override
  Future<Result<UserLearningPath>> saveUserPath(UserLearningPath path) async {
    userPath = path;
    return Success(path);
  }

  @override
  Future<Result<void>> seedIfEmpty(List<LearningPath> seed) async {
    if (paths.isEmpty) paths.addAll(seed);
    return const Success(null);
  }
}

class InMemoryStatisticsRepository implements StatisticsRepository {
  final items = <String, UserStatistics>{};

  @override
  Future<Result<UserStatistics>> getOrCreate(String userId) async {
    final existing = items[userId];
    if (existing != null) return Success(existing);
    final created = UserStatistics(
      id: 'stats_$userId',
      userId: userId,
      updatedAt: DateTime.utc(2026, 1, 1),
    );
    items[userId] = created;
    return Success(created);
  }

  @override
  Future<Result<UserStatistics>> save(UserStatistics statistics) async {
    items[statistics.userId] = statistics;
    return Success(statistics);
  }
}

class InMemoryExerciseHistoryRepository implements ExerciseHistoryRepository {
  final items = <ExerciseHistoryEntry>[];

  @override
  Future<Result<ExerciseHistoryEntry>> save(ExerciseHistoryEntry entry) async {
    items.add(entry);
    items.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return Success(entry);
  }

  @override
  Future<Result<List<ExerciseHistoryEntry>>> listRecent({
    required String userId,
    int limit = 20,
  }) async {
    return Success(
      items.where((item) => item.userId == userId).take(limit).toList(),
    );
  }

  @override
  Future<Result<List<ExerciseHistoryEntry>>> listForDay({
    required String userId,
    required DateTime dayStartUtc,
    required DateTime dayEndUtc,
  }) async {
    return Success(
      items
          .where(
            (item) =>
                item.userId == userId &&
                !item.completedAt.isBefore(dayStartUtc) &&
                !item.completedAt.isAfter(dayEndUtc),
          )
          .toList(),
    );
  }
}

class InMemoryDailyPlanRepository implements DailyPlanRepository {
  final items = <DailyPlan>[];

  @override
  Future<Result<DailyPlan?>> getForDay({
    required String userId,
    required String dayKey,
  }) async {
    for (final item in items) {
      if (item.userId == userId && item.dayKey == dayKey) {
        return Success(item);
      }
    }
    return const Success(null);
  }

  @override
  Future<Result<DailyPlan>> save(DailyPlan plan) async {
    items.removeWhere(
      (item) => item.userId == plan.userId && item.dayKey == plan.dayKey,
    );
    items.add(plan);
    return Success(plan);
  }
}

class InMemoryUserRepository implements UserRepository {
  User? active;

  @override
  Future<Result<User?>> getActiveUser() async => Success(active);

  @override
  Future<Result<User>> getById(String id) async {
    if (active?.id == id) return Success(active!);
    return const Err(NotFoundFailure('User not found'));
  }

  @override
  Future<Result<User>> save(User user) async {
    active = user;
    return Success(user);
  }

  @override
  Future<Result<void>> delete(String id) async {
    if (active?.id == id) active = null;
    return const Success(null);
  }
}

class InMemoryExpressionRepository implements ExpressionRepository {
  final items = <Expression>[];

  @override
  Future<Result<Expression>> save(Expression expression) async {
    items.removeWhere((item) => item.id == expression.id);
    items.add(expression);
    return Success(expression);
  }

  @override
  Future<Result<Expression>> getById(String id) async {
    for (final item in items) {
      if (item.id == id) return Success(item);
    }
    return const Err(NotFoundFailure('Expression not found'));
  }

  @override
  Future<Result<List<Expression>>> listByUser(String userId) async {
    return Success(items.where((item) => item.userId == userId).toList());
  }

  @override
  Future<Result<List<Expression>>> dueForReview({
    required String userId,
    required DateTime asOf,
    int limit = 20,
  }) async {
    final due = items
        .where((item) => item.userId == userId)
        .where(
          (item) =>
              item.nextReviewAt == null || !item.nextReviewAt!.isAfter(asOf),
        )
        .take(limit)
        .toList();
    return Success(due);
  }

  @override
  Future<Result<void>> delete(String id) async {
    items.removeWhere((item) => item.id == id);
    return const Success(null);
  }
}

CompassEngineServiceDeps buildEngineDeps({
  DateTime Function()? clock,
  int Function(int max)? randomIndex,
}) {
  final conversations = InMemoryConversationRepository();
  final missions = InMemoryMissionRepository();
  final skills = InMemorySkillRepository()
    ..items.addAll(DefaultSkillCatalog.skills);
  final progress = InMemorySkillProgressRepository();
  final paths = InMemoryLearningPathRepository();
  final stats = InMemoryStatisticsRepository();
  final history = InMemoryExerciseHistoryRepository();
  final plans = InMemoryDailyPlanRepository();

  return CompassEngineServiceDeps(
    conversations: conversations,
    missions: missions,
    skills: skills,
    progress: progress,
    paths: paths,
    stats: stats,
    history: history,
    plans: plans,
    clock: clock,
    randomIndex: randomIndex,
  );
}

class CompassEngineServiceDeps {
  CompassEngineServiceDeps({
    required this.conversations,
    required this.missions,
    required this.skills,
    required this.progress,
    required this.paths,
    required this.stats,
    required this.history,
    required this.plans,
    this.clock,
    this.randomIndex,
  });

  final InMemoryConversationRepository conversations;
  final InMemoryMissionRepository missions;
  final InMemorySkillRepository skills;
  final InMemorySkillProgressRepository progress;
  final InMemoryLearningPathRepository paths;
  final InMemoryStatisticsRepository stats;
  final InMemoryExerciseHistoryRepository history;
  final InMemoryDailyPlanRepository plans;
  final DateTime Function()? clock;
  final int Function(int max)? randomIndex;
}

class CoachEngineDeps {
  CoachEngineDeps({
    required this.users,
    required this.skills,
    required this.progress,
    required this.history,
    required this.conversations,
    required this.expressions,
    required this.stats,
    required this.plans,
    required this.missions,
    this.clock,
  });

  final InMemoryUserRepository users;
  final InMemorySkillRepository skills;
  final InMemorySkillProgressRepository progress;
  final InMemoryExerciseHistoryRepository history;
  final InMemoryConversationRepository conversations;
  final InMemoryExpressionRepository expressions;
  final InMemoryStatisticsRepository stats;
  final InMemoryDailyPlanRepository plans;
  final InMemoryMissionRepository missions;
  final DateTime Function()? clock;
}

CoachEngineDeps buildCoachDeps({DateTime Function()? clock}) {
  final now = clock?.call() ?? DateTime.utc(2026, 7, 30, 12);
  final users = InMemoryUserRepository()
    ..active = User(
      id: 'user_1',
      displayName: 'Ada',
      nativeLanguage: AppLanguage.ru,
      targetLanguage: AppLanguage.en,
      onboardingCompleted: true,
      createdAt: now,
      updatedAt: now,
    );

  return CoachEngineDeps(
    users: users,
    skills: InMemorySkillRepository()..items.addAll(DefaultSkillCatalog.skills),
    progress: InMemorySkillProgressRepository(),
    history: InMemoryExerciseHistoryRepository(),
    conversations: InMemoryConversationRepository(),
    expressions: InMemoryExpressionRepository(),
    stats: InMemoryStatisticsRepository(),
    plans: InMemoryDailyPlanRepository(),
    missions: InMemoryMissionRepository(),
    clock: clock ?? () => now,
  );
}
