import 'package:isar/isar.dart';

part 'learning_path_collection.g.dart';

@collection
class LearningPathCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index(unique: true, replace: true)
  late String code;

  late String title;
  late String description;
  late List<String> skillIds;
  late bool isDefault;
}

@collection
class UserLearningPathCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index(unique: true, replace: true)
  late String userId;

  late String learningPathId;
  String? currentSkillId;
  late DateTime startedAt;
}
