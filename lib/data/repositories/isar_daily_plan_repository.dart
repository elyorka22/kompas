import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/daily_plan_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/daily_plan.dart';
import 'package:kompas/domain/repositories/daily_plan_repository.dart';

class IsarDailyPlanRepository implements DailyPlanRepository {
  IsarDailyPlanRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<DailyPlan?>> getForDay({
    required String userId,
    required String dayKey,
  }) async {
    try {
      final items = await _isar.dailyPlanCollections
          .filter()
          .userIdEqualTo(userId)
          .findAll();
      final match = items.where((item) => item.dayKey == dayKey).toList();
      if (match.isEmpty) return const Success(null);
      return Success(EntityMappers.toDailyPlan(match.first));
    } catch (error) {
      return Err(StorageFailure('Failed to load daily plan', cause: error));
    }
  }

  @override
  Future<Result<DailyPlan>> save(DailyPlan plan) async {
    try {
      final existing = await _isar.dailyPlanCollections
          .filter()
          .domainIdEqualTo(plan.id)
          .findFirst();
      final mapped =
          EntityMappers.fromDailyPlan(plan, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.dailyPlanCollections.put(mapped);
      });
      return Success(plan);
    } catch (error) {
      return Err(StorageFailure('Failed to save daily plan', cause: error));
    }
  }
}
