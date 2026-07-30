import 'package:isar/isar.dart';

part 'conversation_session_collection.g.dart';

@collection
class ConversationSessionCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String userId;

  late String mode;
  late String status;
  late String title;
  String? prompt;
  String? targetSkillId;
  String? currentExerciseId;
  DateTime? startedAt;
  DateTime? endedAt;
  late int speakingSeconds;
  late int messageCount;
  late int exercisesCompleted;
  late DateTime createdAt;
  late DateTime updatedAt;
}
