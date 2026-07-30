import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/daily_mission_collection.dart';
import 'package:kompas/data/local/collections/goal_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/entities/goal.dart';
import 'package:kompas/domain/enums/goal_enums.dart';
import 'package:kompas/domain/repositories/mission_repository.dart';

class IsarMissionRepository implements MissionRepository {
  IsarMissionRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<List<DailyMission>>> listForDay({
    required String userId,
    required String dayKey,
  }) async {
    try {
      final items = await _isar.dailyMissionCollections
          .filter()
          .userIdEqualTo(userId)
          .and()
          .dayKeyEqualTo(dayKey)
          .findAll();
      return Success(items.map(EntityMappers.toMission).toList());
    } catch (error) {
      return Err(StorageFailure('Failed to list missions', cause: error));
    }
  }

  @override
  Future<Result<DailyMission>> save(DailyMission mission) async {
    try {
      final existing = await _isar.dailyMissionCollections
          .filter()
          .domainIdEqualTo(mission.id)
          .findFirst();
      final mapped =
          EntityMappers.fromMission(mission, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.dailyMissionCollections.put(mapped);
      });
      return Success(mission);
    } catch (error) {
      return Err(StorageFailure('Failed to save mission', cause: error));
    }
  }

  @override
  Future<Result<void>> saveAll(List<DailyMission> missions) async {
    try {
      await _isar.writeTxn(() async {
        for (final mission in missions) {
          final existing = await _isar.dailyMissionCollections
              .filter()
              .domainIdEqualTo(mission.id)
              .findFirst();
          final mapped =
              EntityMappers.fromMission(mission, isarId: existing?.id);
          await _isar.dailyMissionCollections.put(mapped);
        }
      });
      return const Success(null);
    } catch (error) {
      return Err(StorageFailure('Failed to save missions', cause: error));
    }
  }

  @override
  Future<Result<DailyMission>> update(DailyMission mission) => save(mission);
}

class IsarGoalRepository implements GoalRepository {
  IsarGoalRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<List<Goal>>> listActive(String userId) async {
    try {
      final items = await _isar.goalCollections
          .filter()
          .userIdEqualTo(userId)
          .findAll();
      final active = items
          .where((item) => item.status == GoalStatus.active.name)
          .map(EntityMappers.toGoal)
          .toList();
      return Success(active);
    } catch (error) {
      return Err(StorageFailure('Failed to list goals', cause: error));
    }
  }

  @override
  Future<Result<Goal>> save(Goal goal) async {
    try {
      final existing = await _isar.goalCollections
          .filter()
          .domainIdEqualTo(goal.id)
          .findFirst();
      final mapped = EntityMappers.fromGoal(goal, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.goalCollections.put(mapped);
      });
      return Success(goal);
    } catch (error) {
      return Err(StorageFailure('Failed to save goal', cause: error));
    }
  }

  @override
  Future<Result<Goal>> update(Goal goal) => save(goal);
}
