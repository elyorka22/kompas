import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/enums/skill_enums.dart';

/// Stable skill IDs referenced by exercises and learning paths.
abstract final class SkillIds {
  static const conversation = 'skill_conversation';
  static const argumentation = 'skill_argumentation';
  static const storytelling = 'skill_storytelling';
  static const vocabulary = 'skill_vocabulary';
  static const descriptions = 'skill_descriptions';
  static const explanation = 'skill_explanation';
  static const idioms = 'skill_idioms';
  static const naturalSpeech = 'skill_natural_speech';
  static const listening = 'skill_listening';
  static const pronunciation = 'skill_pronunciation';
}

/// Seed catalog for Skill Tree — Compass Engine v1.
abstract final class DefaultSkillCatalog {
  static const List<Skill> skills = [
    Skill(
      id: SkillIds.conversation,
      code: 'conversation.core',
      title: 'Conversation',
      description: 'Keep a natural spoken exchange moving with clear turns.',
      category: SkillCategory.conversation,
      order: 1,
    ),
    Skill(
      id: SkillIds.naturalSpeech,
      code: 'natural_speech.core',
      title: 'Natural Speech',
      description: 'Speak continuously with fewer freezes and fillers.',
      category: SkillCategory.naturalSpeech,
      order: 2,
    ),
    Skill(
      id: SkillIds.vocabulary,
      code: 'vocabulary.core',
      title: 'Vocabulary',
      description: 'Explain and use words precisely in context.',
      category: SkillCategory.vocabulary,
      order: 3,
      prerequisiteSkillIds: [SkillIds.conversation],
    ),
    Skill(
      id: SkillIds.explanation,
      code: 'explanation.core',
      title: 'Explanation',
      description: 'Teach ideas clearly as if helping a beginner.',
      category: SkillCategory.explanation,
      order: 4,
      prerequisiteSkillIds: [SkillIds.vocabulary],
    ),
    Skill(
      id: SkillIds.descriptions,
      code: 'descriptions.core',
      title: 'Descriptions',
      description: 'Describe scenes, objects and feelings with detail.',
      category: SkillCategory.descriptions,
      order: 5,
      prerequisiteSkillIds: [SkillIds.conversation],
    ),
    Skill(
      id: SkillIds.storytelling,
      code: 'storytelling.core',
      title: 'Storytelling',
      description: 'Narrate events with beginning, middle and end.',
      category: SkillCategory.storytelling,
      order: 6,
      prerequisiteSkillIds: [SkillIds.naturalSpeech],
    ),
    Skill(
      id: SkillIds.argumentation,
      code: 'argumentation.core',
      title: 'Argumentation',
      description: 'State a position and support it with reasons.',
      category: SkillCategory.argumentation,
      order: 7,
      prerequisiteSkillIds: [SkillIds.explanation],
    ),
    Skill(
      id: SkillIds.idioms,
      code: 'idioms.core',
      title: 'Idioms',
      description: 'Explain idioms and use them naturally.',
      category: SkillCategory.idioms,
      order: 8,
      prerequisiteSkillIds: [SkillIds.vocabulary, SkillIds.explanation],
    ),
    Skill(
      id: SkillIds.listening,
      code: 'listening.future',
      title: 'Listening',
      description: 'Coming later — comprehension from spoken input.',
      category: SkillCategory.listening,
      order: 90,
      isFuture: true,
    ),
    Skill(
      id: SkillIds.pronunciation,
      code: 'pronunciation.future',
      title: 'Pronunciation',
      description: 'Coming later — clarity of sounds and stress.',
      category: SkillCategory.pronunciation,
      order: 91,
      isFuture: true,
    ),
  ];

  static Skill? byId(String id) {
    for (final skill in skills) {
      if (skill.id == id) return skill;
    }
    return null;
  }

  static List<Skill> get activeSkills =>
      skills.where((skill) => !skill.isFuture).toList();
}
