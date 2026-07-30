import 'package:equatable/equatable.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/prompt_mode.dart';

/// Compact memory digest for prompting (never raw database dumps).
class PromptMemorySummary extends Equatable {
  const PromptMemorySummary({
    this.weakSkills = const [],
    this.strongSkills = const [],
    this.recentTopics = const [],
    this.avoidedTopics = const [],
    this.wordsToReview = const [],
    this.expressionsToPractice = const [],
    this.insights = const [],
    this.preferredLearningHour,
    this.currentStreakDays,
  });

  final List<String> weakSkills;
  final List<String> strongSkills;
  final List<String> recentTopics;
  final List<String> avoidedTopics;
  final List<String> wordsToReview;
  final List<String> expressionsToPractice;
  final List<String> insights;
  final int? preferredLearningHour;
  final int? currentStreakDays;

  @override
  List<Object?> get props => [
        weakSkills,
        strongSkills,
        recentTopics,
        avoidedTopics,
        wordsToReview,
        expressionsToPractice,
        insights,
        preferredLearningHour,
        currentStreakDays,
      ];
}

/// Recent conversation turns for continuity (provider-agnostic plain text).
class PromptConversationContext extends Equatable {
  const PromptConversationContext({
    this.recentTurns = const [],
    this.sessionTopic,
    this.sessionId,
  });

  /// Oldest → newest plain-text turns, e.g. "Learner: …" / "Coach: …".
  final List<String> recentTurns;
  final String? sessionTopic;
  final String? sessionId;

  @override
  List<Object?> get props => [recentTurns, sessionTopic, sessionId];
}

/// Profile slice needed for prompting.
class PromptLearnerProfile extends Equatable {
  const PromptLearnerProfile({
    required this.nativeLanguage,
    required this.targetLanguage,
    this.displayName = '',
    this.currentLevel = 'A2',
    this.learningGoal,
  });

  final AppLanguage nativeLanguage;
  final AppLanguage targetLanguage;
  final String displayName;
  final String currentLevel;
  final String? learningGoal;

  @override
  List<Object?> get props => [
        nativeLanguage,
        targetLanguage,
        displayName,
        currentLevel,
        learningGoal,
      ];
}

/// Input contract for Prompt Engine. Built by app layer from Coach outputs.
class PromptRequest extends Equatable {
  const PromptRequest({
    required this.mode,
    required this.profile,
    required this.difficulty,
    required this.prioritySkillIds,
    required this.memorySummary,
    required this.conversationContext,
    required this.currentGoal,
    this.teachingStrategyReasons = const [],
    this.suggestedTopic,
    this.targetSpeakingSeconds = 90,
    this.missionTitle,
  });

  final PromptMode mode;
  final PromptLearnerProfile profile;
  final ExerciseDifficulty difficulty;
  final List<String> prioritySkillIds;
  final PromptMemorySummary memorySummary;
  final PromptConversationContext conversationContext;
  final String currentGoal;
  final List<String> teachingStrategyReasons;
  final String? suggestedTopic;
  final int targetSpeakingSeconds;
  final String? missionTitle;

  @override
  List<Object?> get props => [
        mode,
        profile,
        difficulty,
        prioritySkillIds,
        memorySummary,
        conversationContext,
        currentGoal,
        teachingStrategyReasons,
        suggestedTopic,
        targetSpeakingSeconds,
        missionTitle,
      ];
}
