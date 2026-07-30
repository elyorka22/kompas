import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';

class RecommendTopicParams {
  const RecommendTopicParams({required this.userId});
  final String userId;
}

class RecommendTopic
    extends UseCase<CoachedRecommendation<String>, RecommendTopicParams> {
  RecommendTopic(this._coach);
  final CoachEngineService _coach;

  @override
  Future<Result<CoachedRecommendation<String>>> call(
    RecommendTopicParams params,
  ) {
    return _coach.recommendTopic(userId: params.userId);
  }
}
