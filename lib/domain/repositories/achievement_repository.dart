import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/achievement.dart';

abstract class AchievementRepository {
  Future<Result<List<Achievement>>> listCatalog();
  Future<Result<void>> seedCatalogIfEmpty(List<Achievement> achievements);
  Future<Result<List<UserAchievement>>> listUserAchievements(String userId);
  Future<Result<UserAchievement>> saveUserAchievement(UserAchievement item);
}
