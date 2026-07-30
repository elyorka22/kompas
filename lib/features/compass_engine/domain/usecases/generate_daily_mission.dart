import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class GenerateDailyMissionParams {
  const GenerateDailyMissionParams({
    required this.userId,
    this.date,
    this.focusSkillId,
  });

  final String userId;
  final DateTime? date;
  final String? focusSkillId;
}

class GenerateDailyMission
    extends UseCase<DailyMission, GenerateDailyMissionParams> {
  GenerateDailyMission(this._engine);

  final CompassEngineService _engine;

  @override
  Future<Result<DailyMission>> call(GenerateDailyMissionParams params) {
    return _engine.generateDailyMission(
      userId: params.userId,
      date: params.date,
      focusSkillId: params.focusSkillId,
    );
  }
}
