import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/data/local/database/isar_database.dart';
import 'package:kompas/data/repositories/isar_achievement_repository.dart';
import 'package:kompas/data/repositories/isar_conversation_repository.dart';
import 'package:kompas/data/repositories/isar_daily_plan_repository.dart';
import 'package:kompas/data/repositories/isar_exercise_history_repository.dart';
import 'package:kompas/data/repositories/isar_expression_repository.dart';
import 'package:kompas/data/repositories/isar_mission_repository.dart';
import 'package:kompas/data/repositories/isar_notebook_repository.dart';
import 'package:kompas/data/repositories/isar_settings_repository.dart';
import 'package:kompas/data/repositories/isar_skill_repository.dart';
import 'package:kompas/data/repositories/isar_speech_analysis_repository.dart';
import 'package:kompas/data/repositories/isar_statistics_repository.dart';
import 'package:kompas/data/repositories/isar_user_repository.dart';
import 'package:kompas/domain/repositories/repositories.dart';
import 'package:kompas/features/ai_adapter/domain/ai_adapter.dart';
import 'package:kompas/services/audio/audio_playback_service.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';
import 'package:kompas/services/coach/learner_context_loader.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';
import 'package:kompas/services/memory/memory_engine_service.dart';
import 'package:kompas/services/progress/progress_calculator_service.dart';
import 'package:kompas/services/prompt/prompt_engine_service.dart';
import 'package:kompas/services/speech/speech_analyzer_service.dart';
import 'package:kompas/services/speech/speech_recording_service.dart';

/// Opened once during [bootstrap] and overridden in [ProviderScope].
final isarDatabaseProvider = Provider<IsarDatabase>((ref) {
  throw UnimplementedError('IsarDatabase must be overridden at startup');
});

final isarProvider = Provider((ref) {
  return ref.watch(isarDatabaseProvider).isar;
});

// ── Repositories ────────────────────────────────────────────────────────────

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return IsarUserRepository(ref.watch(isarProvider));
});

final conversationRepositoryProvider =
    Provider<ConversationRepository>((ref) {
  return IsarConversationRepository(ref.watch(isarProvider));
});

final expressionRepositoryProvider = Provider<ExpressionRepository>((ref) {
  return IsarExpressionRepository(ref.watch(isarProvider));
});

final notebookRepositoryProvider = Provider<NotebookRepository>((ref) {
  return IsarNotebookRepository(ref.watch(isarProvider));
});

final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return IsarMissionRepository(ref.watch(isarProvider));
});

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return IsarGoalRepository(ref.watch(isarProvider));
});

final skillRepositoryProvider = Provider<SkillRepository>((ref) {
  return IsarSkillRepository(ref.watch(isarProvider));
});

final skillProgressRepositoryProvider =
    Provider<SkillProgressRepository>((ref) {
  return IsarSkillProgressRepository(ref.watch(isarProvider));
});

final learningPathRepositoryProvider =
    Provider<LearningPathRepository>((ref) {
  return IsarLearningPathRepository(ref.watch(isarProvider));
});

final achievementRepositoryProvider =
    Provider<AchievementRepository>((ref) {
  return IsarAchievementRepository(ref.watch(isarProvider));
});

final statisticsRepositoryProvider = Provider<StatisticsRepository>((ref) {
  return IsarStatisticsRepository(ref.watch(isarProvider));
});

final speechAnalysisRepositoryProvider =
    Provider<SpeechAnalysisRepository>((ref) {
  return IsarSpeechAnalysisRepository(ref.watch(isarProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return IsarSettingsRepository(ref.watch(isarProvider));
});

final exerciseHistoryRepositoryProvider =
    Provider<ExerciseHistoryRepository>((ref) {
  return IsarExerciseHistoryRepository(ref.watch(isarProvider));
});

final dailyPlanRepositoryProvider = Provider<DailyPlanRepository>((ref) {
  return IsarDailyPlanRepository(ref.watch(isarProvider));
});

// ── Services ────────────────────────────────────────────────────────────────

final progressCalculatorServiceProvider =
    Provider<ProgressCalculatorService>((ref) {
  return ProgressCalculatorService();
});

final compassEngineServiceProvider = Provider<CompassEngineService>((ref) {
  return CompassEngineService(
    conversationRepository: ref.watch(conversationRepositoryProvider),
    missionRepository: ref.watch(missionRepositoryProvider),
    skillRepository: ref.watch(skillRepositoryProvider),
    skillProgressRepository: ref.watch(skillProgressRepositoryProvider),
    learningPathRepository: ref.watch(learningPathRepositoryProvider),
    statisticsRepository: ref.watch(statisticsRepositoryProvider),
    exerciseHistoryRepository: ref.watch(exerciseHistoryRepositoryProvider),
    dailyPlanRepository: ref.watch(dailyPlanRepositoryProvider),
    progressCalculator: ref.watch(progressCalculatorServiceProvider),
  );
});

final memoryEngineServiceProvider = Provider<MemoryEngineService>((ref) {
  return MemoryEngineService();
});

final learnerContextLoaderProvider = Provider<LearnerContextLoader>((ref) {
  return LearnerContextLoader(
    userRepository: ref.watch(userRepositoryProvider),
    skillRepository: ref.watch(skillRepositoryProvider),
    skillProgressRepository: ref.watch(skillProgressRepositoryProvider),
    exerciseHistoryRepository: ref.watch(exerciseHistoryRepositoryProvider),
    conversationRepository: ref.watch(conversationRepositoryProvider),
    expressionRepository: ref.watch(expressionRepositoryProvider),
    statisticsRepository: ref.watch(statisticsRepositoryProvider),
    dailyPlanRepository: ref.watch(dailyPlanRepositoryProvider),
    missionRepository: ref.watch(missionRepositoryProvider),
  );
});

final coachEngineServiceProvider = Provider<CoachEngineService>((ref) {
  return CoachEngineService(
    contextLoader: ref.watch(learnerContextLoaderProvider),
  );
});

final promptEngineServiceProvider = Provider<PromptEngineService>((ref) {
  return const PromptEngineService();
});

final speechAnalyzerServiceProvider = Provider<SpeechAnalyzerService>((ref) {
  return SpeechAnalyzerService();
});

final speechRecordingServiceProvider =
    Provider<SpeechRecordingService>((ref) {
  return StubSpeechRecordingService();
});

final audioPlaybackServiceProvider = Provider<AudioPlaybackService>((ref) {
  return StubAudioPlaybackService();
});

final aiAdapterProvider = Provider<AiAdapter>((ref) {
  return const OfflineNoopAiAdapter();
});
