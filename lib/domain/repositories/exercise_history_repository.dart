import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';

abstract class ExerciseHistoryRepository {
  Future<Result<ExerciseHistoryEntry>> save(ExerciseHistoryEntry entry);

  Future<Result<List<ExerciseHistoryEntry>>> listRecent({
    required String userId,
    int limit = 20,
  });

  Future<Result<List<ExerciseHistoryEntry>>> listForDay({
    required String userId,
    required DateTime dayStartUtc,
    required DateTime dayEndUtc,
  });
}
