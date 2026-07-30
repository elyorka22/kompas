import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/completed_exercise_result.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class CompleteExerciseParams {
  const CompleteExerciseParams({
    required this.userId,
    required this.exerciseId,
    this.sessionId,
  });

  final String userId;
  final String exerciseId;
  final String? sessionId;
}

class CompleteExercise
    extends UseCase<CompletedExerciseResult, CompleteExerciseParams> {
  CompleteExercise(this._engine);

  final CompassEngineService _engine;

  @override
  Future<Result<CompletedExerciseResult>> call(CompleteExerciseParams params) {
    return _engine.completeExercise(
      userId: params.userId,
      exerciseId: params.exerciseId,
      sessionId: params.sessionId,
    );
  }
}
