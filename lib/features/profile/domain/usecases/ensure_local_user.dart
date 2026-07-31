import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/user.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/repositories/user_repository.dart';

/// Creates a default local learner if the app has no active user yet.
///
/// Skips the onboarding wizard — Compass opens straight into the coach.
class EnsureLocalUser extends UseCase<User, NoParams> {
  EnsureLocalUser(this._users);

  final UserRepository _users;

  @override
  Future<Result<User>> call(NoParams params) async {
    final existing = await _users.getActiveUser();
    if (existing.isFailure) {
      return Err(existing.failureOrNull!);
    }
    final user = existing.valueOrNull;
    if (user != null) {
      if (!user.onboardingCompleted) {
        final updated = user.copyWith(
          onboardingCompleted: true,
          updatedAt: DateTime.now().toUtc(),
        );
        return _users.save(updated);
      }
      return Success(user);
    }

    final now = DateTime.now().toUtc();
    final created = User(
      id: IdGenerator.v4(),
      displayName: 'Ученик',
      nativeLanguage: AppLanguage.uz,
      targetLanguage: AppLanguage.ru,
      onboardingCompleted: true,
      dailySpeakingGoalMinutes: 10,
      createdAt: now,
      updatedAt: now,
    );
    return _users.save(created);
  }
}
