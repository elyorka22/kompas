import 'package:isar/isar.dart';

part 'user_statistics_collection.g.dart';

@collection
class UserStatisticsCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index(unique: true, replace: true)
  late String userId;

  late int totalSpeakingSeconds;
  late int totalSessions;
  late int completedSessions;
  late int expressionsSaved;
  late int expressionsMastered;
  late int missionsCompleted;
  late int currentStreakDays;
  late int longestStreakDays;
  late int skillsMastered;
  late int achievementsUnlocked;
  DateTime? lastPracticeAt;
  late DateTime updatedAt;
}
