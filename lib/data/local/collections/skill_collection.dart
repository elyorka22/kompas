import 'package:isar/isar.dart';

part 'skill_collection.g.dart';

@collection
class SkillCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index(unique: true, replace: true)
  late String code;

  late String title;
  late String description;
  late String category;
  late int order;
  late List<String> prerequisiteSkillIds;
  late int xpToMaster;
  late bool isFuture;
}
