import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/user.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/repositories/settings_repository.dart';
import 'package:kompas/domain/repositories/user_repository.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class CompleteOnboardingParams {
  const CompleteOnboardingParams({
    required this.displayName,
    required this.nativeLanguage,
    required this.targetLanguage,
    this.learningGoal,
    this.dailySpeakingGoalMinutes = 10,
    this.dailyReminderEnabled = true,
    this.dailyReminderHour = 9,
  });

  final String displayName;
  final AppLanguage nativeLanguage;
  final AppLanguage targetLanguage;
  final String? learningGoal;
  final int dailySpeakingGoalMinutes;
  final bool dailyReminderEnabled;
  final int dailyReminderHour;
}

/// Creates the local profile, reminder prefs, and first daily plan.
class CompleteOnboarding extends UseCase<User, CompleteOnboardingParams> {
  CompleteOnboarding({
    required UserRepository userRepository,
    required SettingsRepository settingsRepository,
    required CompassEngineService compassEngine,
  })  : _users = userRepository,
        _settings = settingsRepository,
        _engine = compassEngine;

  final UserRepository _users;
  final SettingsRepository _settings;
  final CompassEngineService _engine;

  @override
  Future<Result<User>> call(CompleteOnboardingParams params) async {
    final name = params.displayName.trim();
    if (name.isEmpty) {
      return const Err(ValidationFailure('Display name is required'));
    }
    if (params.nativeLanguage == params.targetLanguage) {
      return const Err(
        ValidationFailure('Native and target languages must differ'),
      );
    }
    if (params.dailySpeakingGoalMinutes < 5) {
      return const Err(
        ValidationFailure('Daily practice time should be at least 5 minutes'),
      );
    }

    final now = DateTime.now().toUtc();
    final user = User(
      id: IdGenerator.v4(),
      displayName: name,
      nativeLanguage: params.nativeLanguage,
      targetLanguage: params.targetLanguage,
      onboardingCompleted: true,
      dailySpeakingGoalMinutes: params.dailySpeakingGoalMinutes,
      learningGoal: params.learningGoal?.trim(),
      createdAt: now,
      updatedAt: now,
    );

    final saved = await _users.save(user);
    if (saved.isFailure) return saved;

    final settingsResult = await _settings.get();
    if (settingsResult.isSuccess) {
      final settings = settingsResult.valueOrNull!;
      await _settings.save(
        settings.copyWith(
          dailyReminderEnabled: params.dailyReminderEnabled,
          dailyReminderHour: params.dailyReminderHour,
          updatedAt: now,
        ),
      );
    }

    final plan = await _engine.generateDailyPlan(userId: user.id);
    if (plan.isFailure) {
      return Err(plan.failureOrNull!);
    }

    return Success(user);
  }
}
