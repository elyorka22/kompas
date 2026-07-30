import 'package:isar/isar.dart';

part 'skill_progress_collection.g.dart';

@collection
class SkillProgressCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String userId;

  @Index()
  late String skillId;

  late String status;
  late int xp;
  DateTime? masteredAt;
  late DateTime updatedAt;
}
