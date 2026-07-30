import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/user.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/repositories/user_repository.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class CompleteOnboardingParams {
  const CompleteOnboardingParams({
    required this.displayName,
    required this.nativeLanguage,
    required this.targetLanguage,
  });

  final String displayName;
  final AppLanguage nativeLanguage;
  final AppLanguage targetLanguage;
}

/// Creates the local profile and first daily plan after onboarding.
class CompleteOnboarding extends UseCase<User, CompleteOnboardingParams> {
  CompleteOnboarding({
    required UserRepository userRepository,
    required CompassEngineService compassEngine,
  })  : _users = userRepository,
        _engine = compassEngine;

  final UserRepository _users;
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

    final now = DateTime.now().toUtc();
    final user = User(
      id: IdGenerator.v4(),
      displayName: name,
      nativeLanguage: params.nativeLanguage,
      targetLanguage: params.targetLanguage,
      onboardingCompleted: true,
      createdAt: now,
      updatedAt: now,
    );

    final saved = await _users.save(user);
    if (saved.isFailure) return saved;

    final plan = await _engine.generateDailyPlan(userId: user.id);
    if (plan.isFailure) {
      return Err(plan.failureOrNull!);
    }

    return Success(user);
  }
}
