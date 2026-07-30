import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/core/utils/date_utils.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/repositories/mission_repository.dart';
import 'package:kompas/services/missions/mission_generator_service.dart';

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

class EnsureDailyMissions
    extends UseCase<List<DailyMission>, EnsureDailyMissionsParams> {
  EnsureDailyMissions({
    required MissionRepository missionRepository,
    required MissionGeneratorService missionGenerator,
  })  : _missions = missionRepository,
        _generator = missionGenerator;

  final MissionRepository _missions;
  final MissionGeneratorService _generator;

  @override
  Future<Result<List<DailyMission>>> call(
    EnsureDailyMissionsParams params,
  ) async {
    final day = params.date ?? DateTime.now();
    final dayKey = KompasDateUtils.dayKey(day);
    final existing = await _missions.listForDay(
      userId: params.userId,
      dayKey: dayKey,
    );
    if (existing.isFailure) return existing;
    if (existing.valueOrNull!.isNotEmpty) return existing;

    final generated = _generator.generateForDay(
      userId: params.userId,
      date: day,
      focusSkillId: params.focusSkillId,
    );
    final saved = await _missions.saveAll(generated);
    if (saved.isFailure) {
      return Err(saved.failureOrNull!);
    }
    return Success(generated);
  }
}
