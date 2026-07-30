import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/daily_plan.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class GenerateDailyPlanParams {
  const GenerateDailyPlanParams({
    required this.userId,
    this.date,
    this.focusSkillId,
  });

  final String userId;
  final DateTime? date;
  final String? focusSkillId;
}

class GenerateDailyPlan extends UseCase<DailyPlan, GenerateDailyPlanParams> {
  GenerateDailyPlan(this._engine);

  final CompassEngineService _engine;

  @override
  Future<Result<DailyPlan>> call(GenerateDailyPlanParams params) {
    return _engine.generateDailyPlan(
      userId: params.userId,
      date: params.date,
      focusSkillId: params.focusSkillId,
    );
  }
}
