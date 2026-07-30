import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/user_statistics.dart';

abstract class StatisticsRepository {
  Future<Result<UserStatistics>> getOrCreate(String userId);
  Future<Result<UserStatistics>> save(UserStatistics statistics);
}
