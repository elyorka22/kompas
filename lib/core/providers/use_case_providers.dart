import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/core_providers.dart';
import 'package:kompas/features/achievements/domain/usecases/load_achievements.dart';
import 'package:kompas/features/compass_engine/domain/usecases/get_session_prompt.dart';
import 'package:kompas/features/conversation/domain/usecases/complete_conversation_session.dart';
import 'package:kompas/features/conversation/domain/usecases/start_conversation_session.dart';
import 'package:kompas/features/daily_goals/domain/usecases/ensure_daily_missions.dart';
import 'package:kompas/features/daily_goals/domain/usecases/update_mission_progress.dart';
import 'package:kompas/features/language/domain/usecases/list_supported_languages.dart';
import 'package:kompas/features/memory_engine/domain/usecases/review_expression.dart';
import 'package:kompas/features/memory_engine/domain/usecases/save_expression.dart';
import 'package:kompas/features/notebook/domain/usecases/list_notebook_items.dart';
import 'package:kompas/features/notebook/domain/usecases/save_notebook_item.dart';
import 'package:kompas/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:kompas/features/profile/domain/usecases/get_active_user.dart';
import 'package:kompas/features/profile/domain/usecases/update_user_profile.dart';
import 'package:kompas/features/progress/domain/usecases/get_user_statistics.dart';
import 'package:kompas/features/settings/domain/usecases/get_settings.dart';
import 'package:kompas/features/settings/domain/usecases/update_settings.dart';
import 'package:kompas/features/skill_tree/domain/usecases/load_skill_tree.dart';
import 'package:kompas/features/speech_analyzer/domain/usecases/analyze_recording.dart';

final completeOnboardingProvider = Provider<CompleteOnboarding>((ref) {
  return CompleteOnboarding(
    userRepository: ref.watch(userRepositoryProvider),
    missionRepository: ref.watch(missionRepositoryProvider),
    missionGenerator: ref.watch(missionGeneratorServiceProvider),
  );
});

final getActiveUserProvider = Provider<GetActiveUser>((ref) {
  return GetActiveUser(ref.watch(userRepositoryProvider));
});

final updateUserProfileProvider = Provider<UpdateUserProfile>((ref) {
  return UpdateUserProfile(ref.watch(userRepositoryProvider));
});

final startConversationSessionProvider =
    Provider<StartConversationSession>((ref) {
  return StartConversationSession(ref.watch(compassEngineServiceProvider));
});

final completeConversationSessionProvider =
    Provider<CompleteConversationSession>((ref) {
  return CompleteConversationSession(
    compassEngine: ref.watch(compassEngineServiceProvider),
    statisticsRepository: ref.watch(statisticsRepositoryProvider),
    progressCalculator: ref.watch(progressCalculatorServiceProvider),
  );
});

final saveNotebookItemProvider = Provider<SaveNotebookItem>((ref) {
  return SaveNotebookItem(ref.watch(notebookRepositoryProvider));
});

final listNotebookItemsProvider = Provider<ListNotebookItems>((ref) {
  return ListNotebookItems(ref.watch(notebookRepositoryProvider));
});

final saveExpressionProvider = Provider<SaveExpression>((ref) {
  return SaveExpression(
    expressionRepository: ref.watch(expressionRepositoryProvider),
    statisticsRepository: ref.watch(statisticsRepositoryProvider),
    progressCalculator: ref.watch(progressCalculatorServiceProvider),
  );
});

final reviewExpressionProvider = Provider<ReviewExpression>((ref) {
  return ReviewExpression(
    expressionRepository: ref.watch(expressionRepositoryProvider),
    memoryEngine: ref.watch(memoryEngineServiceProvider),
    statisticsRepository: ref.watch(statisticsRepositoryProvider),
    progressCalculator: ref.watch(progressCalculatorServiceProvider),
  );
});

final ensureDailyMissionsProvider = Provider<EnsureDailyMissions>((ref) {
  return EnsureDailyMissions(
    missionRepository: ref.watch(missionRepositoryProvider),
    missionGenerator: ref.watch(missionGeneratorServiceProvider),
  );
});

final updateMissionProgressProvider =
    Provider<UpdateMissionProgress>((ref) {
  return UpdateMissionProgress(
    missionRepository: ref.watch(missionRepositoryProvider),
    statisticsRepository: ref.watch(statisticsRepositoryProvider),
    progressCalculator: ref.watch(progressCalculatorServiceProvider),
  );
});

final getUserStatisticsProvider = Provider<GetUserStatistics>((ref) {
  return GetUserStatistics(ref.watch(statisticsRepositoryProvider));
});

final loadSkillTreeProvider = Provider<LoadSkillTree>((ref) {
  return LoadSkillTree(
    skillRepository: ref.watch(skillRepositoryProvider),
    skillProgressRepository: ref.watch(skillProgressRepositoryProvider),
  );
});

final loadAchievementsProvider = Provider<LoadAchievements>((ref) {
  return LoadAchievements(ref.watch(achievementRepositoryProvider));
});

final getSettingsProvider = Provider<GetSettings>((ref) {
  return GetSettings(ref.watch(settingsRepositoryProvider));
});

final updateSettingsProvider = Provider<UpdateSettings>((ref) {
  return UpdateSettings(ref.watch(settingsRepositoryProvider));
});

final analyzeRecordingProvider = Provider<AnalyzeRecording>((ref) {
  return AnalyzeRecording(
    analyzer: ref.watch(speechAnalyzerServiceProvider),
    repository: ref.watch(speechAnalysisRepositoryProvider),
  );
});

final listSupportedLanguagesProvider =
    Provider<ListSupportedLanguages>((ref) {
  return ListSupportedLanguages();
});

final getSessionPromptProvider = Provider<GetSessionPrompt>((ref) {
  return GetSessionPrompt();
});
