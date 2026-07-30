import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/domain/enums/skill_enums.dart';

/// XP and unlock rules for Compass Engine skill progress.
abstract final class SkillXpRules {
  static const int primaryExerciseXp = 20;
  static const int secondaryExerciseXp = 8;
  static const int sessionFinishXp = 10;

  static SkillProgress applyXp({
    required SkillProgress progress,
    required Skill skill,
    required int xpGain,
    required DateTime now,
  }) {
    if (skill.isFuture) return progress;

    final nextXp = progress.xp + xpGain;
    final mastered = nextXp >= skill.xpToMaster;
    return progress.copyWith(
      xp: nextXp,
      status: mastered
          ? SkillStatus.mastered
          : (nextXp > 0 ? SkillStatus.inProgress : progress.status),
      masteredAt: mastered ? (progress.masteredAt ?? now) : progress.masteredAt,
      updatedAt: now,
    );
  }

  static SkillProgress initialFor({
    required String userId,
    required Skill skill,
    required Map<String, SkillProgress> bySkillId,
    required DateTime now,
  }) {
    final existing = bySkillId[skill.id];
    if (existing != null) return existing;

    final status = _initialStatus(skill, bySkillId);
    return SkillProgress(
      id: IdGenerator.v4(),
      userId: userId,
      skillId: skill.id,
      status: status,
      xp: 0,
      updatedAt: now,
    );
  }

  static SkillStatus _initialStatus(
    Skill skill,
    Map<String, SkillProgress> bySkillId,
  ) {
    if (skill.isFuture) return SkillStatus.locked;
    if (skill.prerequisiteSkillIds.isEmpty) return SkillStatus.available;

    for (final prerequisiteId in skill.prerequisiteSkillIds) {
      final progress = bySkillId[prerequisiteId];
      if (progress == null || progress.status != SkillStatus.mastered) {
        return SkillStatus.locked;
      }
    }
    return SkillStatus.available;
  }

  /// After XP updates, unlock skills whose prerequisites are now mastered.
  static List<SkillProgress> refreshUnlocks({
    required String userId,
    required List<Skill> skills,
    required Map<String, SkillProgress> bySkillId,
    required DateTime now,
  }) {
    final updated = <SkillProgress>[];
    for (final skill in skills) {
      if (skill.isFuture) continue;
      final current = initialFor(
        userId: userId,
        skill: skill,
        bySkillId: bySkillId,
        now: now,
      );
      final desired = _initialStatus(skill, bySkillId);
      if (current.status == SkillStatus.locked &&
          desired == SkillStatus.available) {
        final unlocked = current.copyWith(
          status: SkillStatus.available,
          updatedAt: now,
        );
        bySkillId[skill.id] = unlocked;
        updated.add(unlocked);
      } else if (!bySkillId.containsKey(skill.id)) {
        bySkillId[skill.id] = current;
        updated.add(current);
      }
    }
    return updated;
  }
}
