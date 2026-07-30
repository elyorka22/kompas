import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/services/coach/coach_engine_service.dart';

class RecommendMissionParams {
  const RecommendMissionParams({required this.userId});
  final String userId;
}

class RecommendMission
    extends UseCase<CoachedRecommendation<DailyMission>, RecommendMissionParams> {
  RecommendMission(this._coach);
  final CoachEngineService _coach;

  @override
  Future<Result<CoachedRecommendation<DailyMission>>> call(
    RecommendMissionParams params,
  ) {
    return _coach.recommendMission(userId: params.userId);
  }
}
