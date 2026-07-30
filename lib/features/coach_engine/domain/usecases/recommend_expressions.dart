import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';

class RecommendExpressionsParams {
  const RecommendExpressionsParams({required this.userId, this.limit = 5});
  final String userId;
  final int limit;
}

class RecommendExpressions
    extends UseCase<CoachedRecommendation<List<Expression>>, RecommendExpressionsParams> {
  RecommendExpressions(this._coach);
  final CoachEngineService _coach;

  @override
  Future<Result<CoachedRecommendation<List<Expression>>>> call(
    RecommendExpressionsParams params,
  ) {
    return _coach.recommendExpressions(
      userId: params.userId,
      limit: params.limit,
    );
  }
}
