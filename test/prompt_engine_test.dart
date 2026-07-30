import 'package:flutter_test/flutter_test.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/coach_balance.dart';
import 'package:kompas/domain/entities/coached_recommendation.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/entities/learning_strategy.dart';
import 'package:kompas/domain/entities/personal_learning_profile.dart';
import 'package:kompas/domain/entities/prompt_bundle.dart';
import 'package:kompas/domain/entities/prompt_request.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/prompt_mode.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/services/prompt/prompt_engine_service.dart';
import 'package:kompas/services/prompt/prompt_request_factory.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

const _engine = PromptEngineService();

const _requiredHeaders = [
  '## Role',
  '## Mission',
  '## Teaching Strategy',
  '## Memory Summary',
  '## Current Goal',
  '## Forbidden Behaviors',
  '## Expected Behaviors',
  '## Conversation Style',
  '## Stop Conditions',
];

/// Provider-specific tokens that must never appear in generated prompts.
const _providerLeakTokens = [
  'openai',
  'chatgpt',
  'gpt-4',
  'gpt-3',
  'claude-',
  'anthropic',
  'gemini',
  'deepseek',
  'openrouter',
  'grok',
  'xai',
  'messages.role',
  '"role": "system"',
  'chat.completions',
  'contents.parts',
];

PromptLearnerProfile sampleProfile() {
  return const PromptLearnerProfile(
    nativeLanguage: AppLanguage.ru,
    targetLanguage: AppLanguage.en,
    displayName: 'Ada',
    currentLevel: 'A2',
    learningGoal: 'Speak confidently at work',
  );
}

PromptRequest requestFor(
  PromptMode mode, {
  ExerciseDifficulty difficulty = ExerciseDifficulty.core,
}) {
  return PromptRequestFactory.manual(
    mode: mode,
    profile: sampleProfile(),
    currentGoal: 'Practice ${mode.displayName} for 90 seconds.',
    difficulty: difficulty,
    prioritySkillIds: const [SkillIds.conversation],
    memorySummary: const PromptMemorySummary(
      weakSkills: ['Argumentation'],
      strongSkills: ['Conversation'],
      wordsToReview: ['resilient'],
      expressionsToPractice: ['piece of cake'],
      recentTopics: ['morning routine'],
      avoidedTopics: ['politics'],
      insights: ['Needs more speaking time.'],
      preferredLearningHour: 9,
      currentStreakDays: 4,
    ),
    conversationContext: const PromptConversationContext(
      sessionTopic: 'weekend plans',
      recentTurns: [
        'Learner: I usually sleep late on Saturday.',
        'Coach: What do you like to do after waking up?',
      ],
    ),
    teachingStrategyReasons: const [
      'Focus on continuous speech.',
      'Recycle weak vocabulary lightly.',
    ],
    suggestedTopic: 'weekend plans',
    targetSpeakingSeconds: 90,
  );
}

void expectCompleteBundle(PromptBundle bundle, PromptMode mode) {
  expect(bundle.mode, mode);
  expect(bundle.systemPrompt, isNotEmpty);
  expect(bundle.developerPrompt, isNotEmpty);
  expect(bundle.conversationConstraints, isNotEmpty);
  expect(bundle.teachingRules, isNotEmpty);
  expect(bundle.successCriteria, isNotEmpty);
  expect(bundle.followUpStrategy, isNotEmpty);

  final sections = bundle.sections;
  expect(sections.role, isNotEmpty);
  expect(sections.mission, isNotEmpty);
  expect(sections.teachingStrategy, isNotEmpty);
  expect(sections.memorySummary, isNotEmpty);
  expect(sections.currentGoal, isNotEmpty);
  expect(sections.forbiddenBehaviors, isNotEmpty);
  expect(sections.expectedBehaviors, isNotEmpty);
  expect(sections.conversationStyle, isNotEmpty);
  expect(sections.stopConditions, isNotEmpty);

  for (final header in _requiredHeaders) {
    expect(
      bundle.systemPrompt.contains(header),
      isTrue,
      reason: 'Missing section header $header for ${mode.displayName}',
    );
  }

  final haystack = [
    bundle.systemPrompt,
    bundle.developerPrompt,
    ...bundle.conversationConstraints,
    ...bundle.teachingRules,
    ...bundle.successCriteria,
    bundle.followUpStrategy,
  ].join('\n').toLowerCase();

  for (final token in _providerLeakTokens) {
    expect(
      haystack.contains(token.toLowerCase()),
      isFalse,
      reason: 'Provider-specific token "$token" leaked into prompt',
    );
  }
}

void main() {
  group('PromptEngineService active modes', () {
    for (final mode in PromptMode.values.where((m) => !m.isFuture)) {
      test('builds complete provider-agnostic prompt for ${mode.displayName}',
          () {
        final result = _engine.buildPrompt(requestFor(mode));
        expect(result, isA<Success<PromptBundle>>());
        final bundle = (result as Success<PromptBundle>).value;
        expectCompleteBundle(bundle, mode);
        expect(bundle.sections.memorySummary, contains('Weak skills'));
        expect(bundle.sections.currentGoal, contains(mode.displayName));
        expect(
          bundle.developerPrompt,
          contains('provider-agnostic'),
        );
      });
    }
  });

  group('PromptEngineService future modes', () {
    for (final mode in [PromptMode.pronunciation, PromptMode.writing]) {
      test('rejects ${mode.displayName} as unsupported', () {
        final result = _engine.buildPrompt(requestFor(mode));
        expect(result, isA<Err<PromptBundle>>());
        final failure = (result as Err<PromptBundle>).failure;
        expect(failure, isA<UnsupportedFailure>());
      });
    }
  });

  group('PromptEngineService difficulty rules', () {
    test('adds starter scaffolds', () {
      final result = _engine.buildPrompt(
        requestFor(PromptMode.conversation, difficulty: ExerciseDifficulty.starter),
      );
      final bundle = (result as Success<PromptBundle>).value;
      expect(
        bundle.teachingRules.any((r) => r.contains('simple vocabulary')),
        isTrue,
      );
    });

    test('adds stretch challenge', () {
      final result = _engine.buildPrompt(
        requestFor(PromptMode.debate, difficulty: ExerciseDifficulty.stretch),
      );
      final bundle = (result as Success<PromptBundle>).value;
      expect(
        bundle.teachingRules.any((r) => r.contains('Increase lexical')),
        isTrue,
      );
    });
  });

  group('PromptRequestFactory', () {
    test('maps practice modes to prompt modes', () {
      expect(
        PromptRequestFactory.fromPracticeMode(PracticeMode.tellAboutDay),
        PromptMode.conversation,
      );
      expect(
        PromptRequestFactory.fromPracticeMode(PracticeMode.continueStory),
        PromptMode.storytelling,
      );
      expect(
        PromptRequestFactory.fromPracticeMode(PracticeMode.defendOpinion),
        PromptMode.argumentation,
      );
      expect(
        PromptRequestFactory.fromPracticeMode(PracticeMode.explainWord),
        PromptMode.vocabulary,
      );
      expect(
        PromptRequestFactory.fromPracticeMode(PracticeMode.describeImage),
        PromptMode.explanation,
      );
    });

    test('buildFromCoach produces full bundle from strategy', () {
      final now = DateTime.utc(2026, 7, 30);
      final strategy = LearningStrategy(
        dayKey: '2026-07-30',
        primaryMode: PracticeMode.defendOpinion,
        prioritySkillIds: const [SkillIds.argumentation],
        priorityExerciseIds: const ['ex_opinion_remote'],
        difficulty: ExerciseDifficulty.core,
        suggestedSpeakingSeconds: 120,
        wordsToReview: const ['persuade'],
        expressionsToPractice: const ['on the other hand'],
        topicsToAvoid: const ['elections'],
        suggestedTopic: 'remote work',
        reasons: const [
          RecommendationReason(
            code: 'weak_skill',
            message: 'Argumentation needs attention.',
          ),
        ],
      );
      final profile = PersonalLearningProfile(
        id: 'p1',
        userId: 'u1',
        displayName: 'Ada',
        nativeLanguage: AppLanguage.ru,
        targetLanguage: AppLanguage.en,
        weakestSkillIds: const [SkillIds.argumentation],
        strongestSkillIds: const [SkillIds.conversation],
        updatedAt: now,
      );
      final goal = ConversationGoal(
        title: 'Defend a viewpoint',
        prompt: 'Argue for or against remote work calmly.',
        mode: PracticeMode.defendOpinion,
        targetSpeakingSeconds: 120,
        reasons: const [
          RecommendationReason(
            code: 'strategy_goal',
            message: 'Matches today strategy.',
          ),
        ],
      );

      final result = _engine.buildFromCoach(
        strategy: strategy,
        profile: profile,
        conversationGoal: goal,
        overrideMode: PromptMode.debate,
      );

      expect(result, isA<Success<PromptBundle>>());
      final bundle = (result as Success<PromptBundle>).value;
      expectCompleteBundle(bundle, PromptMode.debate);
      expect(bundle.sections.currentGoal, contains('remote work'));
      expect(bundle.sections.mission, contains('Defend a viewpoint'));
    });
  });
}
