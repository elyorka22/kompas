import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/coach_balance.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';

class RecommendConversationGoalParams {
  const RecommendConversationGoalParams({required this.userId});
  final String userId;
}

class RecommendConversationGoal
    extends UseCase<CoachedRecommendation<ConversationGoal>, RecommendConversationGoalParams> {
  RecommendConversationGoal(this._coach);
  final CoachEngineService _coach;

  @override
  Future<Result<CoachedRecommendation<ConversationGoal>>> call(
    RecommendConversationGoalParams params,
  ) {
    return _coach.recommendConversationGoal(userId: params.userId);
  }
}
