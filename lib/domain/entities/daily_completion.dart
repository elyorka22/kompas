import 'package:equatable/equatable.dart';

/// Aggregate completion of today's missions.
class DailyCompletion extends Equatable {
  const DailyCompletion({
    required this.dayKey,
    required this.totalMissions,
    required this.completedMissions,
    required this.ratio,
    required this.isComplete,
  });

  final String dayKey;
  final int totalMissions;
  final int completedMissions;
  final double ratio;
  final bool isComplete;

  @override
  List<Object?> get props => [
        dayKey,
        totalMissions,
        completedMissions,
        ratio,
        isComplete,
      ];
}
