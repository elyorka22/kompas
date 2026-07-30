import 'package:equatable/equatable.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// Today's pedagogical strategy produced by Coach Engine.
class LearningStrategy extends Equatable {
  const LearningStrategy({
    required this.dayKey,
    required this.primaryMode,
    required this.prioritySkillIds,
    required this.priorityExerciseIds,
    required this.difficulty,
    required this.suggestedSpeakingSeconds,
    required this.wordsToReview,
    required this.expressionsToPractice,
    required this.topicsToAvoid,
    required this.reasons,
    this.suggestedTopic,
    this.challengeMode,
    this.challengeReasons = const [],
  });

  final String dayKey;
  final PracticeMode primaryMode;
  final List<String> prioritySkillIds;
  final List<String> priorityExerciseIds;
  final ExerciseDifficulty difficulty;
  final int suggestedSpeakingSeconds;
  final List<String> wordsToReview;
  final List<String> expressionsToPractice;
  final List<String> topicsToAvoid;
  final String? suggestedTopic;
  final PracticeMode? challengeMode;
  final List<RecommendationReason> challengeReasons;
  final List<RecommendationReason> reasons;

  @override
  List<Object?> get props => [
        dayKey,
        primaryMode,
        prioritySkillIds,
        priorityExerciseIds,
        difficulty,
        suggestedSpeakingSeconds,
        wordsToReview,
        expressionsToPractice,
        topicsToAvoid,
        suggestedTopic,
        challengeMode,
        challengeReasons,
        reasons,
      ];
}
