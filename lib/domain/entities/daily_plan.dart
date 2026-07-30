import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// Ordered offline plan for one calendar day.
class DailyPlan extends Equatable {
  const DailyPlan({
    required this.id,
    required this.userId,
    required this.dayKey,
    required this.missionIds,
    required this.recommendedExerciseIds,
    required this.preferredModes,
    required this.createdAt,
    this.focusSkillId,
    this.primaryMissionId,
  });

  final String id;
  final String userId;
  final String dayKey;
  final List<String> missionIds;
  final List<String> recommendedExerciseIds;
  final List<PracticeMode> preferredModes;
  final String? focusSkillId;
  final String? primaryMissionId;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        dayKey,
        missionIds,
        recommendedExerciseIds,
        preferredModes,
        focusSkillId,
        primaryMissionId,
        createdAt,
      ];
}
