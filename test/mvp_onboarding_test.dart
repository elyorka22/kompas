import 'package:flutter_test/flutter_test.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/utils/date_utils.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';
import 'package:kompas/services/progress/progress_calculator_service.dart';

import 'helpers/in_memory_repos.dart';

void main() {
  test('MVP onboarding creates profile, reminder, and first daily plan',
      () async {
    final fixedNow = DateTime.utc(2026, 7, 30, 12);
    final deps = buildEngineDeps(clock: () => fixedNow);
    final users = InMemoryUserRepository();
    final settings = InMemorySettingsRepository();

    final engine = CompassEngineService(
      conversationRepository: deps.conversations,
      missionRepository: deps.missions,
      skillRepository: deps.skills,
      skillProgressRepository: deps.progress,
      learningPathRepository: deps.paths,
      statisticsRepository: deps.stats,
      exerciseHistoryRepository: deps.history,
      dailyPlanRepository: deps.plans,
      progressCalculator: ProgressCalculatorService(),
      clock: () => fixedNow,
    );

    final result = await CompleteOnboarding(
      userRepository: users,
      settingsRepository: settings,
      compassEngine: engine,
    )(
      const CompleteOnboardingParams(
        displayName: 'Ada',
        nativeLanguage: AppLanguage.ru,
        targetLanguage: AppLanguage.en,
        learningGoal: 'Travel with ease',
        dailySpeakingGoalMinutes: 15,
        dailyReminderEnabled: true,
      ),
    );

    expect(result, isA<Success>());
    final user = (result as Success).value;
    expect(user.learningGoal, 'Travel with ease');
    expect(user.dailySpeakingGoalMinutes, 15);
    expect(user.onboardingCompleted, isTrue);

    final savedSettings = (await settings.get()).valueOrNull!;
    expect(savedSettings.dailyReminderEnabled, isTrue);

    final plan = await deps.plans.getForDay(
      userId: user.id,
      dayKey: KompasDateUtils.dayKey(fixedNow),
    );
    expect(plan.valueOrNull, isNotNull);
    expect(plan.valueOrNull!.missionIds, isNotEmpty);

    final session = await engine.startSession(userId: user.id);
    expect(session.isSuccess, isTrue);
    final finished = await engine.finishSession(
      session: session.valueOrNull!,
      speakingSeconds: 90,
    );
    expect(finished.isSuccess, isTrue);
    expect(finished.valueOrNull!.streakDays, greaterThanOrEqualTo(1));
  });
}
