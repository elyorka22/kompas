import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/exercise_history_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';
import 'package:kompas/domain/repositories/exercise_history_repository.dart';

class IsarExerciseHistoryRepository implements ExerciseHistoryRepository {
  IsarExerciseHistoryRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<ExerciseHistoryEntry>> save(ExerciseHistoryEntry entry) async {
    try {
      final existing = await _isar.exerciseHistoryCollections
          .filter()
          .domainIdEqualTo(entry.id)
          .findFirst();
      final mapped =
          EntityMappers.fromExerciseHistory(entry, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.exerciseHistoryCollections.put(mapped);
      });
      return Success(entry);
    } catch (error) {
      return Err(
        StorageFailure('Failed to save exercise history', cause: error),
      );
    }
  }

  @override
  Future<Result<List<ExerciseHistoryEntry>>> listRecent({
    required String userId,
    int limit = 20,
  }) async {
    try {
      final items = await _isar.exerciseHistoryCollections
          .filter()
          .userIdEqualTo(userId)
          .sortByCompletedAtDesc()
          .findAll();
      return Success(
        items.take(limit).map(EntityMappers.toExerciseHistory).toList(),
      );
    } catch (error) {
      return Err(
        StorageFailure('Failed to list exercise history', cause: error),
      );
    }
  }

  @override
  Future<Result<List<ExerciseHistoryEntry>>> listForDay({
    required String userId,
    required DateTime dayStartUtc,
    required DateTime dayEndUtc,
  }) async {
    try {
      final items = await _isar.exerciseHistoryCollections
          .filter()
          .userIdEqualTo(userId)
          .completedAtBetween(dayStartUtc, dayEndUtc)
          .findAll();
      return Success(items.map(EntityMappers.toExerciseHistory).toList());
    } catch (error) {
      return Err(
        StorageFailure('Failed to list day exercise history', cause: error),
      );
    }
  }
}
