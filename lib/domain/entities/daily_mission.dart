import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/goal_enums.dart';

/// One actionable daily assignment produced for the learner.
class DailyMission extends Equatable {
  const DailyMission({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.title,
    required this.description,
    required this.targetValue,
    required this.dayKey,
    required this.createdAt,
    required this.updatedAt,
    this.currentValue = 0,
    this.skillId,
    this.completedAt,
  });

  final String id;
  final String userId;
  final MissionType type;
  final MissionStatus status;
  final String title;
  final String description;
  final int targetValue;
  final int currentValue;
  final String? skillId;
  final String dayKey;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isComplete =>
      status == MissionStatus.completed || currentValue >= targetValue;

  double get progressRatio {
    if (targetValue <= 0) return 0;
    final ratio = currentValue / targetValue;
    if (ratio < 0) return 0;
    if (ratio > 1) return 1;
    return ratio;
  }

  DailyMission copyWith({
    MissionStatus? status,
    int? currentValue,
    DateTime? completedAt,
    DateTime? updatedAt,
  }) {
    return DailyMission(
      id: id,
      userId: userId,
      type: type,
      status: status ?? this.status,
      title: title,
      description: description,
      targetValue: targetValue,
      currentValue: currentValue ?? this.currentValue,
      skillId: skillId,
      dayKey: dayKey,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        status,
        title,
        description,
        targetValue,
        currentValue,
        skillId,
        dayKey,
        completedAt,
        createdAt,
        updatedAt,
      ];
}
