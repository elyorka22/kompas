import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';

class RecommendWordsParams {
  const RecommendWordsParams({required this.userId, this.limit = 8});
  final String userId;
  final int limit;
}

class RecommendWords
    extends UseCase<CoachedRecommendation<List<Expression>>, RecommendWordsParams> {
  RecommendWords(this._coach);
  final CoachEngineService _coach;

  @override
  Future<Result<CoachedRecommendation<List<Expression>>>> call(
    RecommendWordsParams params,
  ) {
    return _coach.recommendWords(userId: params.userId, limit: params.limit);
  }
}
