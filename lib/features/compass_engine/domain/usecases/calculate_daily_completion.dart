import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/daily_completion.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class CalculateDailyCompletionParams {
  const CalculateDailyCompletionParams({
    required this.userId,
    this.date,
  });

  final String userId;
  final DateTime? date;
}

class CalculateDailyCompletion
    extends UseCase<DailyCompletion, CalculateDailyCompletionParams> {
  CalculateDailyCompletion(this._engine);

  final CompassEngineService _engine;

  @override
  Future<Result<DailyCompletion>> call(CalculateDailyCompletionParams params) {
    return _engine.calculateDailyCompletion(
      userId: params.userId,
      date: params.date,
    );
  }
}
