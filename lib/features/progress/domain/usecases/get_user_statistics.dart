import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/user_statistics.dart';
import 'package:kompas/domain/repositories/statistics_repository.dart';

class GetUserStatisticsParams {
  const GetUserStatisticsParams({required this.userId});
  final String userId;
}

class GetUserStatistics
    extends UseCase<UserStatistics, GetUserStatisticsParams> {
  GetUserStatistics(this._statistics);

  final StatisticsRepository _statistics;

  @override
  Future<Result<UserStatistics>> call(GetUserStatisticsParams params) {
    return _statistics.getOrCreate(params.userId);
  }
}
