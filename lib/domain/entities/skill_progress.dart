import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/skill_enums.dart';

/// Per-user progress against a [Skill] node.
class SkillProgress extends Equatable {
  const SkillProgress({
    required this.id,
    required this.userId,
    required this.skillId,
    required this.status,
    required this.xp,
    required this.updatedAt,
    this.masteredAt,
  });

  final String id;
  final String userId;
  final String skillId;
  final SkillStatus status;
  final int xp;
  final DateTime? masteredAt;
  final DateTime updatedAt;

  double progressRatio({required int xpToMaster}) {
    if (xpToMaster <= 0) return 0;
    final ratio = xp / xpToMaster;
    if (ratio < 0) return 0;
    if (ratio > 1) return 1;
    return ratio;
  }

  SkillProgress copyWith({
    SkillStatus? status,
    int? xp,
    DateTime? masteredAt,
    DateTime? updatedAt,
  }) {
    return SkillProgress(
      id: id,
      userId: userId,
      skillId: skillId,
      status: status ?? this.status,
      xp: xp ?? this.xp,
      masteredAt: masteredAt ?? this.masteredAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        skillId,
        status,
        xp,
        masteredAt,
        updatedAt,
      ];
}
