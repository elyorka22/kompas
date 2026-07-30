import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/learning_strategy.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';

class GenerateLearningStrategyParams {
  const GenerateLearningStrategyParams({required this.userId});
  final String userId;
}

class GenerateLearningStrategy
    extends UseCase<LearningStrategy, GenerateLearningStrategyParams> {
  GenerateLearningStrategy(this._coach);
  final CoachEngineService _coach;

  @override
  Future<Result<LearningStrategy>> call(GenerateLearningStrategyParams params) {
    return _coach.generateLearningStrategy(userId: params.userId);
  }
}
