import 'package:isar/isar.dart';

part 'daily_plan_collection.g.dart';

@collection
class DailyPlanCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String userId;

  @Index()
  late String dayKey;

  late List<String> missionIds;
  late List<String> recommendedExerciseIds;
  late List<String> preferredModes;
  String? focusSkillId;
  String? primaryMissionId;
  late DateTime createdAt;
}
