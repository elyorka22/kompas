import 'package:isar/isar.dart';

part 'conversation_message_collection.g.dart';

@collection
class ConversationMessageCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String sessionId;

  late String role;
  late String content;
  String? audioPath;
  int? durationMs;
  String? speechAnalysisId;
  late DateTime createdAt;
}
