import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/enums/goal_enums.dart';
import 'package:kompas/domain/repositories/mission_repository.dart';
import 'package:kompas/domain/repositories/statistics_repository.dart';
import 'package:kompas/services/progress/progress_calculator_service.dart';

class UpdateMissionProgressParams {
  const UpdateMissionProgressParams({
    required this.mission,
    required this.incrementBy,
  });

  final DailyMission mission;
  final int incrementBy;
}

class UpdateMissionProgress
    extends UseCase<DailyMission, UpdateMissionProgressParams> {
  UpdateMissionProgress({
    required MissionRepository missionRepository,
    required StatisticsRepository statisticsRepository,
    required ProgressCalculatorService progressCalculator,
  })  : _missions = missionRepository,
        _statistics = statisticsRepository,
        _progress = progressCalculator;

  final MissionRepository _missions;
  final StatisticsRepository _statistics;
  final ProgressCalculatorService _progress;

  @override
  Future<Result<DailyMission>> call(UpdateMissionProgressParams params) async {
    final nextValue = params.mission.currentValue + params.incrementBy;
    final completed = nextValue >= params.mission.targetValue;
    final now = DateTime.now().toUtc();
    final updated = params.mission.copyWith(
      currentValue: nextValue,
      status: completed ? MissionStatus.completed : MissionStatus.inProgress,
      completedAt: completed ? now : params.mission.completedAt,
      updatedAt: now,
    );
    final saved = await _missions.update(updated);
    if (saved.isFailure) return saved;

    if (completed && params.mission.status != MissionStatus.completed) {
      final stats = await _statistics.getOrCreate(updated.userId);
      if (stats.isSuccess) {
        await _statistics.save(
          _progress.afterMissionCompleted(stats.valueOrNull!),
        );
      }
    }
    return saved;
  }
}
