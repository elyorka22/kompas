import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class CalculateStreakParams {
  const CalculateStreakParams({required this.userId});
  final String userId;
}

class CalculateStreak extends UseCase<int, CalculateStreakParams> {
  CalculateStreak(this._engine);

  final CompassEngineService _engine;

  @override
  Future<Result<int>> call(CalculateStreakParams params) {
    return _engine.calculateStreak(userId: params.userId);
  }
}
