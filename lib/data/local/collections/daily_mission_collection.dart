import 'package:isar/isar.dart';

part 'daily_mission_collection.g.dart';

@collection
class DailyMissionCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String userId;

  @Index()
  late String dayKey;

  late String type;
  late String status;
  late String title;
  late String description;
  late int targetValue;
  late int currentValue;
  String? skillId;
  DateTime? completedAt;
  late DateTime createdAt;
  late DateTime updatedAt;
}
