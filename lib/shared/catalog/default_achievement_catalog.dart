import 'package:kompas/domain/entities/achievement.dart';
import 'package:kompas/domain/enums/misc_enums.dart';

/// Local achievement definitions. Unlocks are computed from statistics.
abstract final class DefaultAchievementCatalog {
  static const List<Achievement> items = [
    Achievement(
      id: 'ach_first_session',
      code: 'speaking.first_session',
      title: 'First session',
      description: 'Complete your first speaking session.',
      category: AchievementCategory.speaking,
      tier: AchievementTier.bronze,
    ),
    Achievement(
      id: 'ach_streak_3',
      code: 'consistency.streak_3',
      title: 'Three-day rhythm',
      description: 'Practice on three consecutive days.',
      category: AchievementCategory.consistency,
      tier: AchievementTier.bronze,
      targetValue: 3,
    ),
    Achievement(
      id: 'ach_expressions_10',
      code: 'vocabulary.expressions_10',
      title: 'Notebook starter',
      description: 'Save 10 expressions.',
      category: AchievementCategory.vocabulary,
      tier: AchievementTier.silver,
      targetValue: 10,
    ),
    Achievement(
      id: 'ach_skill_master_1',
      code: 'skills.master_1',
      title: 'First mastery',
      description: 'Master one skill on the Skill Tree.',
      category: AchievementCategory.skills,
      tier: AchievementTier.gold,
    ),
  ];
}
