import 'package:isar/isar.dart';

part 'notebook_item_collection.g.dart';

@collection
class NotebookItemCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String userId;

  late String type;
  late String title;
  late String body;
  String? expressionId;
  String? sessionId;
  late List<String> tags;
  late bool isPinned;
  late DateTime createdAt;
  late DateTime updatedAt;
}
