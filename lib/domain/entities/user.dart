import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/app_language.dart';

/// Local learner profile. Single active user in MVP (offline).
class User extends Equatable {
  const User({
    required this.id,
    required this.displayName,
    required this.nativeLanguage,
    required this.targetLanguage,
    required this.createdAt,
    required this.updatedAt,
    this.onboardingCompleted = false,
    this.dailySpeakingGoalMinutes = 10,
    this.avatarSeed,
  });

  final String id;
  final String displayName;
  final AppLanguage nativeLanguage;
  final AppLanguage targetLanguage;
  final bool onboardingCompleted;
  final int dailySpeakingGoalMinutes;
  final String? avatarSeed;
  final DateTime createdAt;
  final DateTime updatedAt;

  User copyWith({
    String? displayName,
    AppLanguage? nativeLanguage,
    AppLanguage? targetLanguage,
    bool? onboardingCompleted,
    int? dailySpeakingGoalMinutes,
    String? avatarSeed,
    DateTime? updatedAt,
  }) {
    return User(
      id: id,
      displayName: displayName ?? this.displayName,
      nativeLanguage: nativeLanguage ?? this.nativeLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      dailySpeakingGoalMinutes:
          dailySpeakingGoalMinutes ?? this.dailySpeakingGoalMinutes,
      avatarSeed: avatarSeed ?? this.avatarSeed,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        displayName,
        nativeLanguage,
        targetLanguage,
        onboardingCompleted,
        dailySpeakingGoalMinutes,
        avatarSeed,
        createdAt,
        updatedAt,
      ];
}
