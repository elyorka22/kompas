import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/entities/goal.dart';

abstract class MissionRepository {
  Future<Result<List<DailyMission>>> listForDay({
    required String userId,
    required String dayKey,
  });
  Future<Result<DailyMission>> save(DailyMission mission);
  Future<Result<void>> saveAll(List<DailyMission> missions);
  Future<Result<DailyMission>> update(DailyMission mission);
}

abstract class GoalRepository {
  Future<Result<List<Goal>>> listActive(String userId);
  Future<Result<Goal>> save(Goal goal);
  Future<Result<Goal>> update(Goal goal);
}
