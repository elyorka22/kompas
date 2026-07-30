import 'package:isar/isar.dart';

part 'goal_collection.g.dart';

@collection
class GoalCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String userId;

  late String title;
  late String period;
  late String status;
  late int targetValue;
  late int currentValue;
  late String unit;
  DateTime? startsAt;
  DateTime? endsAt;
  late DateTime createdAt;
  late DateTime updatedAt;
}
