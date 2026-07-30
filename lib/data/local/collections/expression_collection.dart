import 'package:isar/isar.dart';

part 'expression_collection.g.dart';

@collection
class ExpressionCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  @Index()
  late String userId;

  late String targetText;
  String? nativeText;
  String? phonetic;
  String? contextExample;
  late List<String> tags;
  late String source;
  late String strength;
  late double easeFactor;
  late int intervalDays;
  late int repetitions;

  @Index()
  DateTime? nextReviewAt;

  DateTime? lastReviewedAt;
  late DateTime createdAt;
  late DateTime updatedAt;
}
