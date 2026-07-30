import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/enums/skill_enums.dart';

/// Seed catalog for Skill Tree. Content evolves without schema changes.
abstract final class DefaultSkillCatalog {
  static const List<Skill> skills = [
    Skill(
      id: 'skill_fluency_foundation',
      code: 'fluency.foundation',
      title: 'Fluency foundation',
      description: 'Speak continuously for short stretches without freezing.',
      category: SkillCategory.fluency,
      order: 1,
    ),
    Skill(
      id: 'skill_pronunciation_clarity',
      code: 'pronunciation.clarity',
      title: 'Clear pronunciation',
      description: 'Make key sounds intelligible at natural pace.',
      category: SkillCategory.pronunciation,
      order: 2,
    ),
    Skill(
      id: 'skill_vocab_everyday',
      code: 'vocabulary.everyday',
      title: 'Everyday vocabulary',
      description: 'Use high-frequency expressions in real contexts.',
      category: SkillCategory.vocabulary,
      order: 3,
      prerequisiteSkillIds: ['skill_fluency_foundation'],
    ),
    Skill(
      id: 'skill_story_structure',
      code: 'storytelling.structure',
      title: 'Story structure',
      description: 'Tell events with beginning, middle, and end.',
      category: SkillCategory.storytelling,
      order: 4,
      prerequisiteSkillIds: ['skill_fluency_foundation'],
    ),
    Skill(
      id: 'skill_argument_core',
      code: 'argumentation.core',
      title: 'Core argumentation',
      description: 'State a claim and support it with reasons.',
      category: SkillCategory.argumentation,
      order: 5,
      prerequisiteSkillIds: ['skill_story_structure'],
    ),
    Skill(
      id: 'skill_confidence_presence',
      code: 'confidence.presence',
      title: 'Speaking presence',
      description: 'Maintain composure while thinking aloud.',
      category: SkillCategory.confidence,
      order: 6,
    ),
  ];
}
