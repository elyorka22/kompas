import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/coach_balance.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';

class EvaluateDailyBalanceParams {
  const EvaluateDailyBalanceParams({required this.userId, this.date});
  final String userId;
  final DateTime? date;
}

class EvaluateDailyBalance
    extends UseCase<DailyBalance, EvaluateDailyBalanceParams> {
  EvaluateDailyBalance(this._coach);
  final CoachEngineService _coach;

  @override
  Future<Result<DailyBalance>> call(EvaluateDailyBalanceParams params) {
    return _coach.evaluateDailyBalance(userId: params.userId, date: params.date);
  }
}
