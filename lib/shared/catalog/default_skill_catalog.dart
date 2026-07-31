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

/// Seed catalog — Russian conversation coach path.
abstract final class DefaultSkillCatalog {
  static const List<Skill> skills = [
    Skill(
      id: SkillIds.conversation,
      code: 'conversation.core',
      title: 'Разговор',
      description: 'Живой обмен репликами на русском без перевода слово в слово.',
      category: SkillCategory.conversation,
      order: 1,
    ),
    Skill(
      id: SkillIds.naturalSpeech,
      code: 'natural_speech.core',
      title: 'Живая речь',
      description: 'Говорить дольше, с естественными связками и меньше пауз.',
      category: SkillCategory.naturalSpeech,
      order: 2,
    ),
    Skill(
      id: SkillIds.vocabulary,
      code: 'vocabulary.core',
      title: 'Аспекты глаголов',
      description: 'Совершенный и несовершенный вид: сказать/говорить, сделать/делать.',
      category: SkillCategory.vocabulary,
      order: 3,
      prerequisiteSkillIds: [SkillIds.conversation],
    ),
    Skill(
      id: SkillIds.explanation,
      code: 'explanation.core',
      title: 'Грамматика',
      description: 'Частицы, связки и точные конструкции в живой речи.',
      category: SkillCategory.explanation,
      order: 4,
      prerequisiteSkillIds: [SkillIds.vocabulary],
    ),
    Skill(
      id: SkillIds.descriptions,
      code: 'descriptions.core',
      title: 'Глаголы движения',
      description: 'ехать/ездить, идти/ходить и направление движения.',
      category: SkillCategory.descriptions,
      order: 5,
      prerequisiteSkillIds: [SkillIds.conversation],
    ),
    Skill(
      id: SkillIds.storytelling,
      code: 'storytelling.core',
      title: 'Истории',
      description: 'Рассказывать события по-русски с началом, серединой и концом.',
      category: SkillCategory.storytelling,
      order: 6,
      prerequisiteSkillIds: [SkillIds.naturalSpeech],
    ),
    Skill(
      id: SkillIds.argumentation,
      code: 'argumentation.core',
      title: 'Падежи',
      description: 'Родительный, винительный, творительный в реальных фразах.',
      category: SkillCategory.argumentation,
      order: 7,
      prerequisiteSkillIds: [SkillIds.explanation],
    ),
    Skill(
      id: SkillIds.idioms,
      code: 'idioms.core',
      title: 'Идиомы',
      description: 'Русские идиомы, сленг и устойчивые выражения.',
      category: SkillCategory.idioms,
      order: 8,
      prerequisiteSkillIds: [SkillIds.vocabulary, SkillIds.explanation],
    ),
    Skill(
      id: SkillIds.listening,
      code: 'listening.future',
      title: 'Слушание',
      description: 'Позже — понимание живой русской речи на слух.',
      category: SkillCategory.listening,
      order: 90,
      isFuture: true,
    ),
    Skill(
      id: SkillIds.pronunciation,
      code: 'pronunciation.future',
      title: 'Произношение',
      description: 'Позже — ударение, редукция и ясность звуков.',
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
