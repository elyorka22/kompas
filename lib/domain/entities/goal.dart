import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/goal_enums.dart';

/// Longer-horizon intention (daily speaking minutes, weekly sessions, etc.).
class Goal extends Equatable {
  const Goal({
    required this.id,
    required this.userId,
    required this.title,
    required this.period,
    required this.status,
    required this.targetValue,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
    this.currentValue = 0,
    this.startsAt,
    this.endsAt,
  });

  final String id;
  final String userId;
  final String title;
  final GoalPeriod period;
  final GoalStatus status;
  final int targetValue;
  final int currentValue;
  final String unit;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isComplete => currentValue >= targetValue;

  Goal copyWith({
    String? title,
    GoalPeriod? period,
    GoalStatus? status,
    int? targetValue,
    int? currentValue,
    String? unit,
    DateTime? startsAt,
    DateTime? endsAt,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id,
      userId: userId,
      title: title ?? this.title,
      period: period ?? this.period,
      status: status ?? this.status,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      unit: unit ?? this.unit,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        period,
        status,
        targetValue,
        currentValue,
        unit,
        startsAt,
        endsAt,
        createdAt,
        updatedAt,
      ];
}
