import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/achievement.dart';
import 'package:kompas/domain/repositories/achievement_repository.dart';
import 'package:kompas/shared/catalog/default_achievement_catalog.dart';

class AchievementsSnapshot {
  const AchievementsSnapshot({
    required this.catalog,
    required this.userAchievements,
  });

  final List<Achievement> catalog;
  final List<UserAchievement> userAchievements;
}

class LoadAchievementsParams {
  const LoadAchievementsParams({required this.userId});
  final String userId;
}

class LoadAchievements
    extends UseCase<AchievementsSnapshot, LoadAchievementsParams> {
  LoadAchievements(this._achievements);

  final AchievementRepository _achievements;

  @override
  Future<Result<AchievementsSnapshot>> call(
    LoadAchievementsParams params,
  ) async {
    await _achievements.seedCatalogIfEmpty(DefaultAchievementCatalog.items);
    final catalog = await _achievements.listCatalog();
    if (catalog.isFailure) return Err(catalog.failureOrNull!);
    final user = await _achievements.listUserAchievements(params.userId);
    if (user.isFailure) return Err(user.failureOrNull!);
    return Success(
      AchievementsSnapshot(
        catalog: catalog.valueOrNull!,
        userAchievements: user.valueOrNull!,
      ),
    );
  }
}
