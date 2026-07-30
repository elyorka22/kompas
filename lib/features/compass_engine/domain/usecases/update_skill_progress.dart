import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class UpdateSkillProgressParams {
  const UpdateSkillProgressParams({
    required this.userId,
    required this.skillId,
    required this.xpGain,
  });

  final String userId;
  final String skillId;
  final int xpGain;
}

class UpdateSkillProgress
    extends UseCase<SkillProgress, UpdateSkillProgressParams> {
  UpdateSkillProgress(this._engine);

  final CompassEngineService _engine;

  @override
  Future<Result<SkillProgress>> call(UpdateSkillProgressParams params) {
    return _engine.updateSkillProgress(
      userId: params.userId,
      skillId: params.skillId,
      xpGain: params.xpGain,
    );
  }
}
