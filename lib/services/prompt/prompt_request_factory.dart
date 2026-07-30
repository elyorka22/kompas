import 'package:kompas/domain/entities/coach_balance.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/entities/learning_strategy.dart';
import 'package:kompas/domain/entities/personal_learning_profile.dart';
import 'package:kompas/domain/entities/prompt_request.dart';
import 'package:kompas/domain/enums/prompt_mode.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

/// Maps Coach / Compass artifacts into Prompt Engine requests.
abstract final class PromptRequestFactory {
  static PromptMode fromPracticeMode(PracticeMode mode) {
    return switch (mode) {
      PracticeMode.tellAboutDay => PromptMode.conversation,
      PracticeMode.continueStory => PromptMode.storytelling,
      PracticeMode.retellText => PromptMode.storytelling,
      PracticeMode.defendOpinion => PromptMode.argumentation,
      PracticeMode.explainWord => PromptMode.vocabulary,
      PracticeMode.explainIdiom => PromptMode.vocabulary,
      PracticeMode.describeImage => PromptMode.explanation,
    };
  }

  static PromptRequest fromCoach({
    required LearningStrategy strategy,
    required PersonalLearningProfile profile,
    ConversationGoal? conversationGoal,
    PromptMemorySummary? memorySummary,
    PromptConversationContext? conversationContext,
    PromptMode? overrideMode,
    List<String> insightLines = const [],
  }) {
    final mode = overrideMode ?? fromPracticeMode(strategy.primaryMode);
    final goal = conversationGoal?.prompt ??
        strategy.suggestedTopic ??
        'Practice ${mode.displayName} with clear spoken turns.';

    final skillNames = strategy.prioritySkillIds
        .map((id) => DefaultSkillCatalog.byId(id)?.title ?? id)
        .toList();

    final memory = memorySummary ??
        PromptMemorySummary(
          weakSkills: profile.weakestSkillIds
              .map((id) => DefaultSkillCatalog.byId(id)?.title ?? id)
              .toList(),
          strongSkills: profile.strongestSkillIds
              .map((id) => DefaultSkillCatalog.byId(id)?.title ?? id)
              .toList(),
          avoidedTopics: strategy.topicsToAvoid,
          wordsToReview: strategy.wordsToReview,
          expressionsToPractice: strategy.expressionsToPractice,
          insights: insightLines.isEmpty
              ? strategy.reasons.map((reason) => reason.message).toList()
              : insightLines,
          recentTopics: [
            if (strategy.suggestedTopic != null) strategy.suggestedTopic!,
          ],
        );

    return PromptRequest(
      mode: mode,
      profile: PromptLearnerProfile(
        nativeLanguage: profile.nativeLanguage,
        targetLanguage: profile.targetLanguage,
        displayName: profile.displayName,
        currentLevel: profile.currentLevel,
        learningGoal: profile.learningGoal,
      ),
      difficulty: strategy.difficulty,
      prioritySkillIds: strategy.prioritySkillIds,
      memorySummary: memory,
      conversationContext: conversationContext ??
          PromptConversationContext(
            sessionTopic: strategy.suggestedTopic,
          ),
      currentGoal: goal,
      teachingStrategyReasons: [
        ...strategy.reasons.map((reason) => reason.message),
        if (skillNames.isNotEmpty)
          'Priority skills: ${skillNames.join(', ')}.',
        'Difficulty: ${strategy.difficulty.name}.',
      ],
      suggestedTopic: strategy.suggestedTopic,
      targetSpeakingSeconds: conversationGoal?.targetSpeakingSeconds ??
          strategy.suggestedSpeakingSeconds,
      missionTitle: conversationGoal?.title,
    );
  }

  static PromptRequest manual({
    required PromptMode mode,
    required PromptLearnerProfile profile,
    required String currentGoal,
    ExerciseDifficulty difficulty = ExerciseDifficulty.core,
    List<String> prioritySkillIds = const [],
    PromptMemorySummary memorySummary = const PromptMemorySummary(),
    PromptConversationContext conversationContext =
        const PromptConversationContext(),
    List<String> teachingStrategyReasons = const [],
    String? suggestedTopic,
    int targetSpeakingSeconds = 90,
  }) {
    return PromptRequest(
      mode: mode,
      profile: profile,
      difficulty: difficulty,
      prioritySkillIds: prioritySkillIds,
      memorySummary: memorySummary,
      conversationContext: conversationContext,
      currentGoal: currentGoal,
      teachingStrategyReasons: teachingStrategyReasons,
      suggestedTopic: suggestedTopic,
      targetSpeakingSeconds: targetSpeakingSeconds,
    );
  }
}
