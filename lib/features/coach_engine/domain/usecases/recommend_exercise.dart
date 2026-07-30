import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';

class RecommendExerciseParams {
  const RecommendExerciseParams({required this.userId, this.preferredMode});
  final String userId;
  final PracticeMode? preferredMode;
}

class RecommendExercise
    extends UseCase<CoachedRecommendation<Exercise>, RecommendExerciseParams> {
  RecommendExercise(this._coach);
  final CoachEngineService _coach;

  @override
  Future<Result<CoachedRecommendation<Exercise>>> call(
    RecommendExerciseParams params,
  ) {
    return _coach.recommendExercise(
      userId: params.userId,
      preferredMode: params.preferredMode,
    );
  }
}
