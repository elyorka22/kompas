import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

/// Local exercise pool for Compass Engine v1 (no AI).
abstract final class DefaultExerciseCatalog {
  static const List<Exercise> exercises = [
    // ── Explain a word ──────────────────────────────────────────────────
    Exercise(
      id: 'ex_word_resilience',
      code: 'explain_word.resilience',
      title: 'Explain “resilience”',
      prompt:
          'Explain the word “resilience” as if teaching a friend. '
          'Give the meaning, one example from life, and one sentence using it.',
      mode: PracticeMode.explainWord,
      primarySkillId: SkillIds.vocabulary,
      secondarySkillIds: [SkillIds.explanation],
      difficulty: ExerciseDifficulty.starter,
      coachHint: 'Avoid translating only — teach through examples.',
    ),
    Exercise(
      id: 'ex_word_curious',
      code: 'explain_word.curious',
      title: 'Explain “curious”',
      prompt:
          'Explain “curious”. Contrast it with “nosy” if you can. '
          'Use it in two short spoken sentences.',
      mode: PracticeMode.explainWord,
      primarySkillId: SkillIds.vocabulary,
      secondarySkillIds: [SkillIds.explanation],
      difficulty: ExerciseDifficulty.core,
    ),
    Exercise(
      id: 'ex_word_commitment',
      code: 'explain_word.commitment',
      title: 'Explain “commitment”',
      prompt:
          'Explain “commitment”. Give a workplace example and a personal example.',
      mode: PracticeMode.explainWord,
      primarySkillId: SkillIds.vocabulary,
      secondarySkillIds: [SkillIds.explanation, SkillIds.naturalSpeech],
      difficulty: ExerciseDifficulty.stretch,
    ),

    // ── Continue a story ────────────────────────────────────────────────
    Exercise(
      id: 'ex_story_train',
      code: 'continue_story.train',
      title: 'Continue: the empty train',
      prompt:
          'Start from this opening and continue for about one minute: '
          '“I got on an empty train late at night, and then…”',
      mode: PracticeMode.continueStory,
      primarySkillId: SkillIds.storytelling,
      secondarySkillIds: [SkillIds.naturalSpeech],
      difficulty: ExerciseDifficulty.starter,
    ),
    Exercise(
      id: 'ex_story_letter',
      code: 'continue_story.letter',
      title: 'Continue: the letter',
      prompt:
          'Continue this story: “Yesterday I found an old letter under the floorboards…” '
          'Include a clear ending.',
      mode: PracticeMode.continueStory,
      primarySkillId: SkillIds.storytelling,
      secondarySkillIds: [SkillIds.descriptions],
      difficulty: ExerciseDifficulty.core,
    ),
    Exercise(
      id: 'ex_story_stranger',
      code: 'continue_story.stranger',
      title: 'Continue: the stranger',
      prompt:
          'Continue: “A stranger returned my wallet and said one unexpected sentence…”',
      mode: PracticeMode.continueStory,
      primarySkillId: SkillIds.storytelling,
      secondarySkillIds: [SkillIds.conversation],
      difficulty: ExerciseDifficulty.stretch,
    ),

    // ── Describe an image (placeholder) ─────────────────────────────────
    Exercise(
      id: 'ex_image_market',
      code: 'describe_image.market',
      title: 'Describe a busy market',
      prompt:
          'Imagine a busy outdoor market. Describe what you see, hear and smell. '
          '(Image placeholder — use your imagination.)',
      mode: PracticeMode.describeImage,
      primarySkillId: SkillIds.descriptions,
      secondarySkillIds: [SkillIds.vocabulary],
      difficulty: ExerciseDifficulty.starter,
    ),
    Exercise(
      id: 'ex_image_rainy_street',
      code: 'describe_image.rainy_street',
      title: 'Describe a rainy street',
      prompt:
          'Describe a rainy city street at dusk. Focus on light, movement and mood. '
          '(Image placeholder.)',
      mode: PracticeMode.describeImage,
      primarySkillId: SkillIds.descriptions,
      secondarySkillIds: [SkillIds.naturalSpeech],
      difficulty: ExerciseDifficulty.core,
    ),
    Exercise(
      id: 'ex_image_kitchen',
      code: 'describe_image.kitchen',
      title: 'Describe a kitchen scene',
      prompt:
          'Describe someone cooking in a small kitchen. Include objects and actions. '
          '(Image placeholder.)',
      mode: PracticeMode.describeImage,
      primarySkillId: SkillIds.descriptions,
      secondarySkillIds: [SkillIds.vocabulary],
      difficulty: ExerciseDifficulty.stretch,
    ),

    // ── Tell about your day ─────────────────────────────────────────────
    Exercise(
      id: 'ex_day_morning',
      code: 'tell_day.morning',
      title: 'Tell about your morning',
      prompt:
          'Tell about your morning from waking up until now. Speak for at least 60 seconds.',
      mode: PracticeMode.tellAboutDay,
      primarySkillId: SkillIds.conversation,
      secondarySkillIds: [SkillIds.naturalSpeech],
      difficulty: ExerciseDifficulty.starter,
    ),
    Exercise(
      id: 'ex_day_highlight',
      code: 'tell_day.highlight',
      title: 'Today’s highlight',
      prompt:
          'What was the highlight of your day so far? Why did it matter to you?',
      mode: PracticeMode.tellAboutDay,
      primarySkillId: SkillIds.conversation,
      secondarySkillIds: [SkillIds.naturalSpeech, SkillIds.explanation],
      difficulty: ExerciseDifficulty.core,
    ),
    Exercise(
      id: 'ex_day_challenge',
      code: 'tell_day.challenge',
      title: 'A small challenge today',
      prompt:
          'Describe one challenge you faced today and how you handled it.',
      mode: PracticeMode.tellAboutDay,
      primarySkillId: SkillIds.naturalSpeech,
      secondarySkillIds: [SkillIds.conversation],
      difficulty: ExerciseDifficulty.stretch,
    ),

    // ── Defend your opinion ─────────────────────────────────────────────
    Exercise(
      id: 'ex_opinion_remote',
      code: 'defend_opinion.remote_work',
      title: 'Defend: remote work',
      prompt:
          'Do people work better from home? Pick a side and defend it with two reasons.',
      mode: PracticeMode.defendOpinion,
      primarySkillId: SkillIds.argumentation,
      secondarySkillIds: [SkillIds.explanation],
      difficulty: ExerciseDifficulty.starter,
    ),
    Exercise(
      id: 'ex_opinion_cities',
      code: 'defend_opinion.cities',
      title: 'Defend: big cities',
      prompt:
          'Is life better in a big city than in a small town? Defend your opinion.',
      mode: PracticeMode.defendOpinion,
      primarySkillId: SkillIds.argumentation,
      secondarySkillIds: [SkillIds.conversation],
      difficulty: ExerciseDifficulty.core,
    ),
    Exercise(
      id: 'ex_opinion_screens',
      code: 'defend_opinion.screens',
      title: 'Defend: less screen time',
      prompt:
          'Should adults limit daily screen time? Argue for your position and address one counterpoint.',
      mode: PracticeMode.defendOpinion,
      primarySkillId: SkillIds.argumentation,
      secondarySkillIds: [SkillIds.explanation, SkillIds.naturalSpeech],
      difficulty: ExerciseDifficulty.stretch,
    ),

    // ── Retell a text ───────────────────────────────────────────────────
    Exercise(
      id: 'ex_retell_park',
      code: 'retell.park',
      title: 'Retell: the park visit',
      prompt:
          'Retell this in your own words: “Maya visited the park, fed the ducks, '
          'lost her keys, then found them under a bench.” Add one detail of your own.',
      mode: PracticeMode.retellText,
      primarySkillId: SkillIds.storytelling,
      secondarySkillIds: [SkillIds.conversation],
      difficulty: ExerciseDifficulty.starter,
    ),
    Exercise(
      id: 'ex_retell_meeting',
      code: 'retell.meeting',
      title: 'Retell: the meeting',
      prompt:
          'Retell: “The team met at nine, delayed the launch by a week, and asked Leo '
          'to rewrite the plan.” Keep the facts, change the wording.',
      mode: PracticeMode.retellText,
      primarySkillId: SkillIds.storytelling,
      secondarySkillIds: [SkillIds.explanation],
      difficulty: ExerciseDifficulty.core,
    ),
    Exercise(
      id: 'ex_retell_storm',
      code: 'retell.storm',
      title: 'Retell: the storm',
      prompt:
          'Retell: “A sudden storm stopped the festival. People shared umbrellas, '
          'and a musician kept playing under a tent.” Speak for about a minute.',
      mode: PracticeMode.retellText,
      primarySkillId: SkillIds.storytelling,
      secondarySkillIds: [SkillIds.descriptions, SkillIds.naturalSpeech],
      difficulty: ExerciseDifficulty.stretch,
    ),

    // ── Explain an idiom ────────────────────────────────────────────────
    Exercise(
      id: 'ex_idiom_piece_of_cake',
      code: 'explain_idiom.piece_of_cake',
      title: 'Explain “a piece of cake”',
      prompt:
          'Explain the idiom “a piece of cake”. Give the meaning and a real-life example.',
      mode: PracticeMode.explainIdiom,
      primarySkillId: SkillIds.idioms,
      secondarySkillIds: [SkillIds.explanation, SkillIds.vocabulary],
      difficulty: ExerciseDifficulty.starter,
    ),
    Exercise(
      id: 'ex_idiom_break_ice',
      code: 'explain_idiom.break_the_ice',
      title: 'Explain “break the ice”',
      prompt:
          'Explain “break the ice”. When would you use it in conversation?',
      mode: PracticeMode.explainIdiom,
      primarySkillId: SkillIds.idioms,
      secondarySkillIds: [SkillIds.conversation, SkillIds.explanation],
      difficulty: ExerciseDifficulty.core,
    ),
    Exercise(
      id: 'ex_idiom_hit_ground',
      code: 'explain_idiom.hit_the_ground_running',
      title: 'Explain “hit the ground running”',
      prompt:
          'Explain “hit the ground running”. Use it in a short story about starting a new job.',
      mode: PracticeMode.explainIdiom,
      primarySkillId: SkillIds.idioms,
      secondarySkillIds: [SkillIds.storytelling, SkillIds.explanation],
      difficulty: ExerciseDifficulty.stretch,
    ),
  ];

  static Exercise? byId(String id) {
    for (final exercise in exercises) {
      if (exercise.id == id) return exercise;
    }
    return null;
  }

  static List<Exercise> byMode(PracticeMode mode) {
    return exercises
        .where((exercise) => exercise.isActive && exercise.mode == mode)
        .toList();
  }

  static List<Exercise> byPrimarySkill(String skillId) {
    return exercises
        .where(
          (exercise) =>
              exercise.isActive && exercise.primarySkillId == skillId,
        )
        .toList();
  }

  static List<Exercise> get active =>
      exercises.where((exercise) => exercise.isActive).toList();
}
