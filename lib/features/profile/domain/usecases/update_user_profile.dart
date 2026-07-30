import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/user.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/repositories/user_repository.dart';

class UpdateUserProfileParams {
  const UpdateUserProfileParams({
    required this.user,
    this.displayName,
    this.nativeLanguage,
    this.targetLanguage,
    this.dailySpeakingGoalMinutes,
    this.learningGoal,
  });

  final User user;
  final String? displayName;
  final AppLanguage? nativeLanguage;
  final AppLanguage? targetLanguage;
  final int? dailySpeakingGoalMinutes;
  final String? learningGoal;
}

class UpdateUserProfile extends UseCase<User, UpdateUserProfileParams> {
  UpdateUserProfile(this._users);

  final UserRepository _users;

  @override
  Future<Result<User>> call(UpdateUserProfileParams params) async {
    final updated = params.user.copyWith(
      displayName: params.displayName,
      nativeLanguage: params.nativeLanguage,
      targetLanguage: params.targetLanguage,
      dailySpeakingGoalMinutes: params.dailySpeakingGoalMinutes,
      learningGoal: params.learningGoal,
      updatedAt: DateTime.now().toUtc(),
    );
    if (updated.displayName.trim().isEmpty) {
      return const Err(ValidationFailure('Display name is required'));
    }
    return _users.save(updated);
  }
}
