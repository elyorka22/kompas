import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class RecommendNextExerciseParams {
  const RecommendNextExerciseParams({
    required this.userId,
    this.preferredMode,
    this.focusSkillId,
  });

  final String userId;
  final PracticeMode? preferredMode;
  final String? focusSkillId;
}

class RecommendNextExercise
    extends UseCase<Exercise, RecommendNextExerciseParams> {
  RecommendNextExercise(this._engine);

  final CompassEngineService _engine;

  @override
  Future<Result<Exercise>> call(RecommendNextExerciseParams params) {
    return _engine.recommendNextExercise(
      userId: params.userId,
      preferredMode: params.preferredMode,
      focusSkillId: params.focusSkillId,
    );
  }
}
