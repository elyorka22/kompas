import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/core_providers.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/daily_completion.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';
import 'package:kompas/domain/entities/learning_strategy.dart';
import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/features/coach_engine/domain/usecases/generate_learning_strategy.dart';
import 'package:kompas/features/coach_engine/domain/usecases/recommend_exercise.dart';
import 'package:kompas/features/compass_engine/domain/usecases/calculate_daily_completion.dart';
import 'package:kompas/features/compass_engine/domain/usecases/recommend_next_exercise.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/features/skill_tree/providers/skill_tree_providers.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

final dailyCompletionProvider = FutureProvider<DailyCompletion?>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return null;
  final result = await ref.watch(calculateDailyCompletionProvider)(
    CalculateDailyCompletionParams(userId: user.id),
  );
  return result.valueOrNull;
});

final learningStrategyProvider = FutureProvider<LearningStrategy?>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return null;
  final result = await ref.watch(generateLearningStrategyProvider)(
    GenerateLearningStrategyParams(userId: user.id),
  );
  return result.valueOrNull;
});

final recommendedExerciseProvider = FutureProvider<Exercise?>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return null;
  final coached = await ref.watch(coachRecommendExerciseProvider)(
    RecommendExerciseParams(userId: user.id),
  );
  if (coached.isSuccess && coached.valueOrNull != null) {
    return coached.valueOrNull!.value;
  }
  final fallback = await ref.watch(recommendNextExerciseProvider)(
    RecommendNextExerciseParams(userId: user.id),
  );
  return fallback.valueOrNull;
});

final recentSessionsProvider =
    FutureProvider<List<ConversationSession>>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return const [];
  final result = await ref.watch(conversationRepositoryProvider).listSessions(
        userId: user.id,
        status: SessionStatus.completed,
        limit: 5,
      );
  return result.valueOrNull ?? const [];
});

final recentExerciseHistoryProvider =
    FutureProvider<List<ExerciseHistoryEntry>>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return const [];
  final result = await ref.watch(exerciseHistoryRepositoryProvider).listRecent(
        userId: user.id,
        limit: 8,
      );
  return result.valueOrNull ?? const [];
});

class SkillProgressView {
  const SkillProgressView({
    required this.skill,
    required this.progress,
  });

  final Skill skill;
  final SkillProgress progress;

  double get ratio {
    if (skill.xpToMaster <= 0) return 0;
    final value = progress.xp / skill.xpToMaster;
    if (value < 0) return 0;
    if (value > 1) return 1;
    return value;
  }
}

final skillProgressViewsProvider =
    FutureProvider<List<SkillProgressView>>((ref) async {
  final snapshot = await ref.watch(skillTreeProvider.future);
  if (snapshot == null) return const [];
  final byId = {
    for (final item in snapshot.progress) item.skillId: item,
  };

  final views = <SkillProgressView>[];
  for (final skill in snapshot.skills.where((s) => !s.isFuture)) {
    final progress = byId[skill.id];
    if (progress == null) continue;
    views.add(SkillProgressView(skill: skill, progress: progress));
  }
  views.sort((a, b) => b.progress.xp.compareTo(a.progress.xp));
  return views;
});

final memoryInsightsProvider = FutureProvider<List<String>>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return const [];
  final result =
      await ref.watch(memoryEngineServiceProvider).buildInsights(userId: user.id);
  return result.valueOrNull ?? const [];
});

/// Resolves a skill title for UI without inventing catalog entries.
String skillTitle(String? skillId) {
  if (skillId == null) return 'Speaking';
  return DefaultSkillCatalog.byId(skillId)?.title ?? skillId;
}
