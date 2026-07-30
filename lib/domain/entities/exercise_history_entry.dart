import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// Record of a completed exercise — fuels anti-repeat rotation.
class ExerciseHistoryEntry extends Equatable {
  const ExerciseHistoryEntry({
    required this.id,
    required this.userId,
    required this.exerciseId,
    required this.mode,
    required this.primarySkillId,
    required this.completedAt,
    this.sessionId,
    this.xpEarned = 0,
  });

  final String id;
  final String userId;
  final String exerciseId;
  final String? sessionId;
  final PracticeMode mode;
  final String primarySkillId;
  final int xpEarned;
  final DateTime completedAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        exerciseId,
        sessionId,
        mode,
        primarySkillId,
        xpEarned,
        completedAt,
      ];
}
