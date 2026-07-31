import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/core_providers.dart';
import 'package:kompas/features/achievements/domain/usecases/load_achievements.dart';
import 'package:kompas/features/coach_engine/domain/usecases/evaluate_daily_balance.dart';
import 'package:kompas/features/coach_engine/domain/usecases/evaluate_weekly_balance.dart';
import 'package:kompas/features/coach_engine/domain/usecases/generate_learning_strategy.dart';
import 'package:kompas/features/coach_engine/domain/usecases/recommend_conversation_goal.dart';
import 'package:kompas/features/coach_engine/domain/usecases/recommend_difficulty.dart';
import 'package:kompas/features/coach_engine/domain/usecases/recommend_exercise.dart';
import 'package:kompas/features/coach_engine/domain/usecases/recommend_expressions.dart';
import 'package:kompas/features/coach_engine/domain/usecases/recommend_mission.dart';
import 'package:kompas/features/coach_engine/domain/usecases/recommend_topic.dart';
import 'package:kompas/features/coach_engine/domain/usecases/recommend_words.dart';
import 'package:kompas/features/compass_engine/domain/usecases/calculate_daily_completion.dart';
import 'package:kompas/features/compass_engine/domain/usecases/calculate_streak.dart';
import 'package:kompas/features/compass_engine/domain/usecases/complete_exercise.dart';
import 'package:kompas/features/compass_engine/domain/usecases/finish_session.dart';
import 'package:kompas/features/compass_engine/domain/usecases/generate_daily_mission.dart';
import 'package:kompas/features/compass_engine/domain/usecases/generate_daily_plan.dart';
import 'package:kompas/features/compass_engine/domain/usecases/recommend_next_exercise.dart';
import 'package:kompas/features/compass_engine/domain/usecases/start_session.dart';
import 'package:kompas/features/compass_engine/domain/usecases/update_skill_progress.dart';
import 'package:kompas/features/daily_goals/domain/usecases/ensure_daily_missions.dart';
import 'package:kompas/features/daily_goals/domain/usecases/update_mission_progress.dart';
import 'package:kompas/features/language/domain/usecases/list_supported_languages.dart';
import 'package:kompas/features/memory_engine/domain/usecases/review_expression.dart';
import 'package:kompas/features/memory_engine/domain/usecases/save_expression.dart';
import 'package:kompas/features/notebook/domain/usecases/list_notebook_items.dart';
import 'package:kompas/features/notebook/domain/usecases/save_notebook_item.dart';
import 'package:kompas/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:kompas/features/profile/domain/usecases/ensure_local_user.dart';
import 'package:kompas/features/profile/domain/usecases/get_active_user.dart';
import 'package:kompas/features/profile/domain/usecases/update_user_profile.dart';
import 'package:kompas/features/progress/domain/usecases/get_user_statistics.dart';
import 'package:kompas/features/ai_adapter/domain/usecases/send_coach_turn.dart';
import 'package:kompas/features/prompt_engine/domain/usecases/build_prompt.dart';
import 'package:kompas/features/prompt_engine/domain/usecases/build_prompt_from_coach.dart';
import 'package:kompas/features/settings/domain/usecases/get_settings.dart';
import 'package:kompas/features/settings/domain/usecases/update_settings.dart';
import 'package:kompas/features/skill_tree/domain/usecases/load_skill_tree.dart';
import 'package:kompas/features/speech_analyzer/domain/usecases/analyze_recording.dart';

final completeOnboardingProvider = Provider<CompleteOnboarding>((ref) {
  return CompleteOnboarding(
    userRepository: ref.watch(userRepositoryProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
    compassEngine: ref.watch(compassEngineServiceProvider),
  );
});

final getActiveUserProvider = Provider<GetActiveUser>((ref) {
  return GetActiveUser(ref.watch(userRepositoryProvider));
});

final ensureLocalUserProvider = Provider<EnsureLocalUser>((ref) {
  return EnsureLocalUser(ref.watch(userRepositoryProvider));
});

final updateUserProfileProvider = Provider<UpdateUserProfile>((ref) {
  return UpdateUserProfile(ref.watch(userRepositoryProvider));
});

// ── Compass Engine use cases ────────────────────────────────────────────────

final startSessionProvider = Provider<StartSession>((ref) {
  return StartSession(ref.watch(compassEngineServiceProvider));
});

final finishSessionProvider = Provider<FinishSession>((ref) {
  return FinishSession(ref.watch(compassEngineServiceProvider));
});

final generateDailyMissionProvider = Provider<GenerateDailyMission>((ref) {
  return GenerateDailyMission(ref.watch(compassEngineServiceProvider));
});

final generateDailyPlanProvider = Provider<GenerateDailyPlan>((ref) {
  return GenerateDailyPlan(ref.watch(compassEngineServiceProvider));
});

final recommendNextExerciseProvider =
    Provider<RecommendNextExercise>((ref) {
  return RecommendNextExercise(ref.watch(compassEngineServiceProvider));
});

final updateSkillProgressProvider = Provider<UpdateSkillProgress>((ref) {
  return UpdateSkillProgress(ref.watch(compassEngineServiceProvider));
});

final completeExerciseProvider = Provider<CompleteExercise>((ref) {
  return CompleteExercise(ref.watch(compassEngineServiceProvider));
});

final calculateStreakProvider = Provider<CalculateStreak>((ref) {
  return CalculateStreak(ref.watch(compassEngineServiceProvider));
});

final calculateDailyCompletionProvider =
    Provider<CalculateDailyCompletion>((ref) {
  return CalculateDailyCompletion(ref.watch(compassEngineServiceProvider));
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
    compassEngine: ref.watch(compassEngineServiceProvider),
    missionRepository: ref.watch(missionRepositoryProvider),
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

// ── Coach Engine use cases ──────────────────────────────────────────────────

final generateLearningStrategyProvider =
    Provider<GenerateLearningStrategy>((ref) {
  return GenerateLearningStrategy(ref.watch(coachEngineServiceProvider));
});

final coachRecommendExerciseProvider = Provider<RecommendExercise>((ref) {
  return RecommendExercise(ref.watch(coachEngineServiceProvider));
});

final coachRecommendTopicProvider = Provider<RecommendTopic>((ref) {
  return RecommendTopic(ref.watch(coachEngineServiceProvider));
});

final coachRecommendMissionProvider = Provider<RecommendMission>((ref) {
  return RecommendMission(ref.watch(coachEngineServiceProvider));
});

final coachRecommendWordsProvider = Provider<RecommendWords>((ref) {
  return RecommendWords(ref.watch(coachEngineServiceProvider));
});

final coachRecommendExpressionsProvider =
    Provider<RecommendExpressions>((ref) {
  return RecommendExpressions(ref.watch(coachEngineServiceProvider));
});

final coachRecommendDifficultyProvider =
    Provider<RecommendDifficulty>((ref) {
  return RecommendDifficulty(ref.watch(coachEngineServiceProvider));
});

final coachRecommendConversationGoalProvider =
    Provider<RecommendConversationGoal>((ref) {
  return RecommendConversationGoal(ref.watch(coachEngineServiceProvider));
});

final evaluateDailyBalanceProvider = Provider<EvaluateDailyBalance>((ref) {
  return EvaluateDailyBalance(ref.watch(coachEngineServiceProvider));
});

final evaluateWeeklyBalanceProvider = Provider<EvaluateWeeklyBalance>((ref) {
  return EvaluateWeeklyBalance(ref.watch(coachEngineServiceProvider));
});

// ── Prompt Engine use cases ─────────────────────────────────────────────────

final buildPromptProvider = Provider<BuildPrompt>((ref) {
  return BuildPrompt(ref.watch(promptEngineServiceProvider));
});

final buildPromptFromCoachProvider = Provider<BuildPromptFromCoach>((ref) {
  return BuildPromptFromCoach(ref.watch(promptEngineServiceProvider));
});

final sendCoachTurnProvider = Provider<SendCoachTurn>((ref) {
  return SendCoachTurn(
    aiAdapter: ref.watch(aiAdapterProvider),
    conversations: ref.watch(conversationRepositoryProvider),
    generateStrategy: ref.watch(generateLearningStrategyProvider),
    recommendGoal: ref.watch(coachRecommendConversationGoalProvider),
    buildPrompt: ref.watch(buildPromptFromCoachProvider),
    memory: ref.watch(memoryEngineServiceProvider),
  );
});
