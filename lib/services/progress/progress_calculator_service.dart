import 'package:kompas/core/utils/date_utils.dart';
import 'package:kompas/domain/entities/user_statistics.dart';

/// Applies incremental statistic updates after practice events.
class ProgressCalculatorService {
  UserStatistics afterSpeaking({
    required UserStatistics current,
    required int speakingSeconds,
    required bool sessionCompleted,
  }) {
    final now = DateTime.now().toUtc();
    final streak = _nextStreak(current, now);

    return current.copyWith(
      totalSpeakingSeconds: current.totalSpeakingSeconds + speakingSeconds,
      totalSessions: current.totalSessions + 1,
      completedSessions:
          current.completedSessions + (sessionCompleted ? 1 : 0),
      currentStreakDays: streak.current,
      longestStreakDays: streak.longest,
      lastPracticeAt: now,
      updatedAt: now,
    );
  }

  UserStatistics afterExpressionSaved(UserStatistics current) {
    return current.copyWith(
      expressionsSaved: current.expressionsSaved + 1,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  UserStatistics afterExpressionMastered(UserStatistics current) {
    return current.copyWith(
      expressionsMastered: current.expressionsMastered + 1,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  UserStatistics afterMissionCompleted(UserStatistics current) {
    return current.copyWith(
      missionsCompleted: current.missionsCompleted + 1,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  UserStatistics afterSkillMastered(UserStatistics current) {
    return current.copyWith(
      skillsMastered: current.skillsMastered + 1,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  ({int current, int longest}) _nextStreak(
    UserStatistics current,
    DateTime now,
  ) {
    final last = current.lastPracticeAt;
    if (last == null) {
      return (current: 1, longest: current.longestStreakDays.clamp(1, 9999));
    }

    final days = KompasDateUtils.calendarDaysBetween(last, now);
    if (days == 0) {
      return (
        current: current.currentStreakDays == 0 ? 1 : current.currentStreakDays,
        longest: current.longestStreakDays,
      );
    }
    if (days == 1) {
      final next = current.currentStreakDays + 1;
      return (
        current: next,
        longest: next > current.longestStreakDays
            ? next
            : current.longestStreakDays,
      );
    }
    return (current: 1, longest: current.longestStreakDays);
  }
}
