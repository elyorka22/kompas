import 'package:isar/isar.dart';

part 'user_collection.g.dart';

@collection
class UserCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  late String displayName;
  late String nativeLanguageCode;
  late String targetLanguageCode;
  late bool onboardingCompleted;
  late int dailySpeakingGoalMinutes;
  String? learningGoal;
  String? avatarSeed;
  late DateTime createdAt;
  late DateTime updatedAt;
}
