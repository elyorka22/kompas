import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/coach_balance.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';

class EvaluateWeeklyBalanceParams {
  const EvaluateWeeklyBalanceParams({required this.userId, this.asOf});
  final String userId;
  final DateTime? asOf;
}

class EvaluateWeeklyBalance
    extends UseCase<WeeklyBalance, EvaluateWeeklyBalanceParams> {
  EvaluateWeeklyBalance(this._coach);
  final CoachEngineService _coach;

  @override
  Future<Result<WeeklyBalance>> call(EvaluateWeeklyBalanceParams params) {
    return _coach.evaluateWeeklyBalance(userId: params.userId, asOf: params.asOf);
  }
}
