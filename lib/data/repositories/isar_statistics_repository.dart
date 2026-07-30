import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/data/local/collections/user_statistics_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/user_statistics.dart';
import 'package:kompas/domain/repositories/statistics_repository.dart';

class IsarStatisticsRepository implements StatisticsRepository {
  IsarStatisticsRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<UserStatistics>> getOrCreate(String userId) async {
    try {
      final existing = await _isar.userStatisticsCollections
          .filter()
          .userIdEqualTo(userId)
          .findFirst();
      if (existing != null) {
        return Success(EntityMappers.toStatistics(existing));
      }
      final created = UserStatistics(
        id: IdGenerator.v4(),
        userId: userId,
        updatedAt: DateTime.now().toUtc(),
      );
      return save(created);
    } catch (error) {
      return Err(StorageFailure('Failed to load statistics', cause: error));
    }
  }

  @override
  Future<Result<UserStatistics>> save(UserStatistics statistics) async {
    try {
      final existing = await _isar.userStatisticsCollections
          .filter()
          .domainIdEqualTo(statistics.id)
          .findFirst();
      final mapped =
          EntityMappers.fromStatistics(statistics, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.userStatisticsCollections.put(mapped);
      });
      return Success(statistics);
    } catch (error) {
      return Err(StorageFailure('Failed to save statistics', cause: error));
    }
  }
}
