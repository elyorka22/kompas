import 'package:kompas/domain/entities/learning_path.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

abstract final class DefaultLearningPathCatalog {
  static const List<LearningPath> paths = [
    LearningPath(
      id: 'path_speaker_core',
      code: 'speaker.core',
      title: 'Core speaker',
      description:
          'Conversation → natural speech → vocabulary → explanation → '
          'descriptions → storytelling → argumentation → idioms.',
      skillIds: [
        SkillIds.conversation,
        SkillIds.naturalSpeech,
        SkillIds.vocabulary,
        SkillIds.explanation,
        SkillIds.descriptions,
        SkillIds.storytelling,
        SkillIds.argumentation,
        SkillIds.idioms,
      ],
      isDefault: true,
    ),
  ];
}
