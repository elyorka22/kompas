import 'package:kompas/domain/entities/learning_path.dart';

abstract final class DefaultLearningPathCatalog {
  static const List<LearningPath> paths = [
    LearningPath(
      id: 'path_speaker_core',
      code: 'speaker.core',
      title: 'Core speaker',
      description:
          'Build fluency, vocabulary, storytelling and argumentation in sequence.',
      skillIds: [
        'skill_fluency_foundation',
        'skill_pronunciation_clarity',
        'skill_vocab_everyday',
        'skill_story_structure',
        'skill_argument_core',
        'skill_confidence_presence',
      ],
      isDefault: true,
    ),
  ];
}
