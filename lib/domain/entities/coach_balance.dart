import 'package:equatable/equatable.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// Balance of practice modes / skills for one day.
class DailyBalance extends Equatable {
  const DailyBalance({
    required this.dayKey,
    required this.modeCounts,
    required this.skillCounts,
    required this.totalExercises,
    required this.isBalanced,
    required this.reasons,
    this.overusedMode,
    this.neglectedSkillId,
  });

  final String dayKey;
  final Map<PracticeMode, int> modeCounts;
  final Map<String, int> skillCounts;
  final int totalExercises;
  final bool isBalanced;
  final PracticeMode? overusedMode;
  final String? neglectedSkillId;
  final List<RecommendationReason> reasons;

  @override
  List<Object?> get props => [
        dayKey,
        modeCounts,
        skillCounts,
        totalExercises,
        isBalanced,
        overusedMode,
        neglectedSkillId,
        reasons,
      ];
}

/// Balance across the last 7 practice days.
class WeeklyBalance extends Equatable {
  const WeeklyBalance({
    required this.weekStartDayKey,
    required this.activeDays,
    required this.modeCounts,
    required this.skillCounts,
    required this.totalSpeakingSeconds,
    required this.isBalanced,
    required this.reasons,
    this.dominantMode,
    this.neglectedSkillId,
  });

  final String weekStartDayKey;
  final int activeDays;
  final Map<PracticeMode, int> modeCounts;
  final Map<String, int> skillCounts;
  final int totalSpeakingSeconds;
  final bool isBalanced;
  final PracticeMode? dominantMode;
  final String? neglectedSkillId;
  final List<RecommendationReason> reasons;

  @override
  List<Object?> get props => [
        weekStartDayKey,
        activeDays,
        modeCounts,
        skillCounts,
        totalSpeakingSeconds,
        isBalanced,
        dominantMode,
        neglectedSkillId,
        reasons,
      ];
}

/// Conversation goal for the next session.
class ConversationGoal extends Equatable {
  const ConversationGoal({
    required this.title,
    required this.prompt,
    required this.mode,
    required this.targetSpeakingSeconds,
    required this.reasons,
  });

  final String title;
  final String prompt;
  final PracticeMode mode;
  final int targetSpeakingSeconds;
  final List<RecommendationReason> reasons;

  @override
  List<Object?> get props => [
        title,
        prompt,
        mode,
        targetSpeakingSeconds,
        reasons,
      ];
}
