import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/achievement_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/achievement.dart';
import 'package:kompas/domain/repositories/achievement_repository.dart';

class IsarAchievementRepository implements AchievementRepository {
  IsarAchievementRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<List<Achievement>>> listCatalog() async {
    try {
      final items = await _isar.achievementCollections.where().findAll();
      return Success(items.map(EntityMappers.toAchievement).toList());
    } catch (error) {
      return Err(
        StorageFailure('Failed to list achievements', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> seedCatalogIfEmpty(
    List<Achievement> achievements,
  ) async {
    try {
      final count = await _isar.achievementCollections.count();
      if (count > 0) return const Success(null);
      await _isar.writeTxn(() async {
        for (final achievement in achievements) {
          await _isar.achievementCollections
              .put(EntityMappers.fromAchievement(achievement));
        }
      });
      return const Success(null);
    } catch (error) {
      return Err(
        StorageFailure('Failed to seed achievements', cause: error),
      );
    }
  }

  @override
  Future<Result<List<UserAchievement>>> listUserAchievements(
    String userId,
  ) async {
    try {
      final items = await _isar.userAchievementCollections
          .filter()
          .userIdEqualTo(userId)
          .findAll();
      return Success(items.map(EntityMappers.toUserAchievement).toList());
    } catch (error) {
      return Err(
        StorageFailure('Failed to list user achievements', cause: error),
      );
    }
  }

  @override
  Future<Result<UserAchievement>> saveUserAchievement(
    UserAchievement item,
  ) async {
    try {
      final existing = await _isar.userAchievementCollections
          .filter()
          .domainIdEqualTo(item.id)
          .findFirst();
      final mapped =
          EntityMappers.fromUserAchievement(item, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.userAchievementCollections.put(mapped);
      });
      return Success(item);
    } catch (error) {
      return Err(
        StorageFailure('Failed to save user achievement', cause: error),
      );
    }
  }
}
