import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';

class RecommendDifficultyParams {
  const RecommendDifficultyParams({required this.userId});
  final String userId;
}

class RecommendDifficulty
    extends UseCase<CoachedRecommendation<ExerciseDifficulty>, RecommendDifficultyParams> {
  RecommendDifficulty(this._coach);
  final CoachEngineService _coach;

  @override
  Future<Result<CoachedRecommendation<ExerciseDifficulty>>> call(
    RecommendDifficultyParams params,
  ) {
    return _coach.recommendDifficulty(userId: params.userId);
  }
}
