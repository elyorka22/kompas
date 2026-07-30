import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/skill_enums.dart';

/// Node on the Skill Tree. Content is local/static in MVP.
class Skill extends Equatable {
  const Skill({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.category,
    required this.order,
    this.prerequisiteSkillIds = const [],
    this.xpToMaster = 100,
    this.isFuture = false,
  });

  final String id;
  final String code;
  final String title;
  final String description;
  final SkillCategory category;
  final int order;
  final List<String> prerequisiteSkillIds;
  final int xpToMaster;

  /// Future skills stay locked until a later product version.
  final bool isFuture;

  @override
  List<Object?> get props => [
        id,
        code,
        title,
        description,
        category,
        order,
        prerequisiteSkillIds,
        xpToMaster,
        isFuture,
      ];
}
