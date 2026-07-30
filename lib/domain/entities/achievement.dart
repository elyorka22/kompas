import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/misc_enums.dart';

/// Unlockable milestone. Catalog is local; unlocks are per-user.
class Achievement extends Equatable {
  const Achievement({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.category,
    required this.tier,
    this.targetValue = 1,
  });

  final String id;
  final String code;
  final String title;
  final String description;
  final AchievementCategory category;
  final AchievementTier tier;
  final int targetValue;

  @override
  List<Object?> get props => [
        id,
        code,
        title,
        description,
        category,
        tier,
        targetValue,
      ];
}

/// User-specific unlock state for an [Achievement].
class UserAchievement extends Equatable {
  const UserAchievement({
    required this.id,
    required this.userId,
    required this.achievementId,
    required this.progress,
    required this.updatedAt,
    this.unlockedAt,
  });

  final String id;
  final String userId;
  final String achievementId;
  final int progress;
  final DateTime? unlockedAt;
  final DateTime updatedAt;

  bool get isUnlocked => unlockedAt != null;

  UserAchievement copyWith({
    int? progress,
    DateTime? unlockedAt,
    DateTime? updatedAt,
  }) {
    return UserAchievement(
      id: id,
      userId: userId,
      achievementId: achievementId,
      progress: progress ?? this.progress,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        achievementId,
        progress,
        unlockedAt,
        updatedAt,
      ];
}
