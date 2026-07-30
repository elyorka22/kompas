import 'package:isar/isar.dart';

part 'achievement_collection.g.dart';

@collection
class AchievementCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index(unique: true, replace: true)
  late String code;

  late String title;
  late String description;
  late String category;
  late String tier;
  late int targetValue;
}

@collection
class UserAchievementCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String userId;

  @Index()
  late String achievementId;

  late int progress;
  DateTime? unlockedAt;
  late DateTime updatedAt;
}
