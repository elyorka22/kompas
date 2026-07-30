import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

/// Metadata linking practice modes to skills and display titles.
abstract final class PracticeModeCatalog {
  static String title(PracticeMode mode) {
    return switch (mode) {
      PracticeMode.explainWord => 'Explain a word',
      PracticeMode.continueStory => 'Continue a story',
      PracticeMode.describeImage => 'Describe an image',
      PracticeMode.tellAboutDay => 'Tell about your day',
      PracticeMode.defendOpinion => 'Defend your opinion',
      PracticeMode.retellText => 'Retell a text',
      PracticeMode.explainIdiom => 'Explain an idiom',
    };
  }

  static String defaultPrompt(PracticeMode mode) {
    return switch (mode) {
      PracticeMode.explainWord =>
        'Choose a useful word and explain it clearly with examples.',
      PracticeMode.continueStory =>
        'Continue the story with a beginning, middle and end.',
      PracticeMode.describeImage =>
        'Describe the scene in detail — what you see, hear and feel.',
      PracticeMode.tellAboutDay =>
        'Talk about your day naturally for at least one minute.',
      PracticeMode.defendOpinion =>
        'Pick a position and defend it with clear reasons.',
      PracticeMode.retellText =>
        'Retell the text in your own words without memorizing.',
      PracticeMode.explainIdiom =>
        'Explain the idiom and show how to use it in real life.',
    };
  }

  static String primarySkillId(PracticeMode mode) {
    return switch (mode) {
      PracticeMode.explainWord => SkillIds.vocabulary,
      PracticeMode.continueStory => SkillIds.storytelling,
      PracticeMode.describeImage => SkillIds.descriptions,
      PracticeMode.tellAboutDay => SkillIds.conversation,
      PracticeMode.defendOpinion => SkillIds.argumentation,
      PracticeMode.retellText => SkillIds.storytelling,
      PracticeMode.explainIdiom => SkillIds.idioms,
    };
  }

  static List<PracticeMode> modesForSkill(String skillId) {
    return PracticeMode.values
        .where((mode) => primarySkillId(mode) == skillId)
        .toList();
  }
}
