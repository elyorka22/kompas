import 'package:isar/isar.dart';

part 'exercise_history_collection.g.dart';

@collection
class ExerciseHistoryCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String userId;

  @Index()
  late String exerciseId;

  String? sessionId;
  late String mode;
  late String primarySkillId;
  late int xpEarned;

  @Index()
  late DateTime completedAt;
}
