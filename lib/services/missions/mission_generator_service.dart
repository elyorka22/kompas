import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/core/utils/date_utils.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/enums/goal_enums.dart';

/// Builds the daily mission set from learner context.
///
/// Pure generation — persistence is handled by use cases / repositories.
class MissionGeneratorService {
  List<DailyMission> generateForDay({
    required String userId,
    DateTime? date,
    String? focusSkillId,
  }) {
    final day = date ?? DateTime.now();
    final dayKey = KompasDateUtils.dayKey(day);
    final now = DateTime.now().toUtc();

    return [
      DailyMission(
        id: IdGenerator.v4(),
        userId: userId,
        type: MissionType.speakMinutes,
        status: MissionStatus.pending,
        title: 'Speak today',
        description:
            'Accumulate ${AppConstants.defaultDailySpeakingMinutes} minutes of speaking practice.',
        targetValue: AppConstants.defaultDailySpeakingMinutes,
        dayKey: dayKey,
        createdAt: now,
        updatedAt: now,
      ),
      DailyMission(
        id: IdGenerator.v4(),
        userId: userId,
        type: MissionType.completeSession,
        status: MissionStatus.pending,
        title: 'Finish one session',
        description: 'Complete a conversation or speaking drill session.',
        targetValue: 1,
        dayKey: dayKey,
        skillId: focusSkillId,
        createdAt: now,
        updatedAt: now,
      ),
      DailyMission(
        id: IdGenerator.v4(),
        userId: userId,
        type: MissionType.reviewExpressions,
        status: MissionStatus.pending,
        title: 'Review expressions',
        description: 'Recall expressions due in Memory Engine.',
        targetValue: AppConstants.defaultReviewBatchSize,
        dayKey: dayKey,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }
}
