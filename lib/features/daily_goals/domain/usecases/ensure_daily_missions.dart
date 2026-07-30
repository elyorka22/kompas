import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/core/utils/date_utils.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/repositories/mission_repository.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class EnsureDailyMissionsParams {
  const EnsureDailyMissionsParams({
    required this.userId,
    this.date,
    this.focusSkillId,
  });

  final String userId;
  final DateTime? date;
  final String? focusSkillId;
}

/// Ensures today's missions exist via Compass Engine daily plan generation.
class EnsureDailyMissions
    extends UseCase<List<DailyMission>, EnsureDailyMissionsParams> {
  EnsureDailyMissions({
    required CompassEngineService compassEngine,
    required MissionRepository missionRepository,
  })  : _engine = compassEngine,
        _missions = missionRepository;

  final CompassEngineService _engine;
  final MissionRepository _missions;

  @override
  Future<Result<List<DailyMission>>> call(
    EnsureDailyMissionsParams params,
  ) async {
    final day = params.date ?? DateTime.now();
    final plan = await _engine.generateDailyPlan(
      userId: params.userId,
      date: day,
      focusSkillId: params.focusSkillId,
    );
    if (plan.isFailure) return Err(plan.failureOrNull!);

    return _missions.listForDay(
      userId: params.userId,
      dayKey: KompasDateUtils.dayKey(day),
    );
  }
}
