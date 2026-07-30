import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/daily_plan.dart';

abstract class DailyPlanRepository {
  Future<Result<DailyPlan?>> getForDay({
    required String userId,
    required String dayKey,
  });

  Future<Result<DailyPlan>> save(DailyPlan plan);
}
