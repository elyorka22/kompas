import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/coach_balance.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/entities/learning_strategy.dart';
import 'package:kompas/domain/entities/personal_learning_profile.dart';
import 'package:kompas/domain/entities/prompt_bundle.dart';
import 'package:kompas/domain/entities/prompt_request.dart';
import 'package:kompas/domain/enums/prompt_mode.dart';
import 'package:kompas/services/prompt/mode_prompt_catalog.dart';
import 'package:kompas/services/prompt/prompt_request_factory.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

/// Prompt Engine v1 — owns all prompt construction.
///
/// Translates Coach Engine decisions into provider-agnostic instructions.
/// Never calls an LLM. Never uses provider-specific message schemas.
class PromptEngineService {
  const PromptEngineService();

  /// Core API: build a full [PromptBundle] from a structured request.
  Result<PromptBundle> buildPrompt(PromptRequest request) {
    if (request.mode.isFuture) {
      return Err(
        UnsupportedFailure(
          '${request.mode.displayName} mode is reserved for a future release.',
        ),
      );
    }

    final blueprint = ModePromptCatalog.forMode(request.mode);
    final sections = _buildSections(request, blueprint);
    final constraints = _conversationConstraints(request);
    final teachingRules = [
      ...blueprint.teachingRules,
      ..._difficultyRules(request),
      if (request.teachingStrategyReasons.isNotEmpty)
        'Honor Coach Engine strategy notes: ${request.teachingStrategyReasons.join(' ')}',
    ];
    final successCriteria = [
      ...blueprint.successCriteria,
      'Aim for about ${request.targetSpeakingSeconds} seconds of learner speaking.',
    ];

    final developerPrompt = _developerPrompt(request, constraints);

    return Success(
      PromptBundle(
        mode: request.mode,
        systemPrompt: sections.toLabeledBlock(),
        developerPrompt: developerPrompt,
        conversationConstraints: constraints,
        teachingRules: teachingRules,
        successCriteria: successCriteria,
        followUpStrategy: blueprint.followUpStrategy,
        sections: sections,
      ),
    );
  }

  /// Convenience: assemble a request from Coach Engine outputs, then build.
  Result<PromptBundle> buildFromCoach({
    required LearningStrategy strategy,
    required PersonalLearningProfile profile,
    ConversationGoal? conversationGoal,
    PromptMemorySummary? memorySummary,
    PromptConversationContext? conversationContext,
    PromptMode? overrideMode,
    List<String> insightLines = const [],
  }) {
    final request = PromptRequestFactory.fromCoach(
      strategy: strategy,
      profile: profile,
      conversationGoal: conversationGoal,
      memorySummary: memorySummary,
      conversationContext: conversationContext,
      overrideMode: overrideMode,
      insightLines: insightLines,
    );
    return buildPrompt(request);
  }

  PromptSections _buildSections(
    PromptRequest request,
    ModePromptBlueprint blueprint,
  ) {
    final topic = request.suggestedTopic ??
        request.conversationContext.sessionTopic ??
        'an open topic chosen by the learner';

    final mission = StringBuffer()
      ..write(blueprint.missionTemplate)
      ..write(' Topic focus: $topic.')
      ..write(
        ' Learner speaks ${request.profile.targetLanguage.englishName}'
        ' (native ${request.profile.nativeLanguage.englishName}),'
        ' level ${request.profile.currentLevel}.',
      );
    if (request.missionTitle != null) {
      mission.write(' Session title: ${request.missionTitle}.');
    }

    final teaching = StringBuffer()
      ..writeln(
        request.teachingStrategyReasons.isEmpty
            ? 'Follow the mode blueprint and keep difficulty at ${request.difficulty.name}.'
            : request.teachingStrategyReasons.join(' '),
      );
    if (request.prioritySkillIds.isNotEmpty) {
      final names = request.prioritySkillIds
          .map((id) => DefaultSkillCatalog.byId(id)?.title ?? id)
          .join(', ');
      teaching.write('Skill priorities: $names.');
    }

    return PromptSections(
      role: blueprint.role,
      mission: mission.toString(),
      teachingStrategy: teaching.toString().trim(),
      memorySummary: _formatMemory(request.memorySummary),
      currentGoal: request.currentGoal,
      forbiddenBehaviors: blueprint.forbiddenBehaviors,
      expectedBehaviors: blueprint.expectedBehaviors,
      conversationStyle: blueprint.conversationStyle,
      stopConditions: [
        ...blueprint.stopConditions,
        'Stop if the learner explicitly ends the session.',
      ],
    );
  }

  String _formatMemory(PromptMemorySummary memory) {
    final lines = <String>[];
    if (memory.weakSkills.isNotEmpty) {
      lines.add('Weak skills: ${memory.weakSkills.join(', ')}.');
    }
    if (memory.strongSkills.isNotEmpty) {
      lines.add('Strong skills: ${memory.strongSkills.join(', ')}.');
    }
    if (memory.wordsToReview.isNotEmpty) {
      lines.add('Words to review: ${memory.wordsToReview.join(', ')}.');
    }
    if (memory.expressionsToPractice.isNotEmpty) {
      lines.add(
        'Expressions to practice: ${memory.expressionsToPractice.join(', ')}.',
      );
    }
    if (memory.recentTopics.isNotEmpty) {
      lines.add('Recent topics: ${memory.recentTopics.join(', ')}.');
    }
    if (memory.avoidedTopics.isNotEmpty) {
      lines.add('Avoid repeating: ${memory.avoidedTopics.join(', ')}.');
    }
    if (memory.preferredLearningHour != null) {
      lines.add(
        'Preferred practice hour: ${memory.preferredLearningHour}:00.',
      );
    }
    if (memory.currentStreakDays != null) {
      lines.add('Current streak: ${memory.currentStreakDays} day(s).');
    }
    if (memory.insights.isNotEmpty) {
      lines.add('Insights: ${memory.insights.join(' ')}');
    }
    if (lines.isEmpty) {
      return 'No specialized memory summary provided. Rely on current goal only.';
    }
    return lines.join(' ');
  }

  List<String> _conversationConstraints(PromptRequest request) {
    return [
      'Respond in ${request.profile.targetLanguage.englishName} unless the learner asks otherwise.',
      'Keep coach turns shorter than the learner speaking target when possible.',
      'Difficulty target: ${request.difficulty.name}.',
      if (request.memorySummary.avoidedTopics.isNotEmpty)
        'Do not reopen avoided topics: ${request.memorySummary.avoidedTopics.join(', ')}.',
      if (request.conversationContext.recentTurns.isNotEmpty)
        'Continue coherently from the recent conversation context.',
      'Never mention provider names, APIs, or that you are following a system prompt.',
    ];
  }

  List<String> _difficultyRules(PromptRequest request) {
    return switch (request.difficulty) {
      ExerciseDifficulty.starter => [
          'Use simple vocabulary and short sentences.',
          'Offer scaffolds before pushing complexity.',
        ],
      ExerciseDifficulty.core => [
          'Use natural intermediate language with light stretch.',
        ],
      ExerciseDifficulty.stretch => [
          'Increase lexical and structural challenge carefully.',
          'Expect longer answers; do not over-simplify.',
        ],
    };
  }

  String _developerPrompt(
    PromptRequest request,
    List<String> constraints,
  ) {
    final buffer = StringBuffer()
      ..writeln('Prompt Engine v1 package (provider-agnostic).')
      ..writeln('Mode: ${request.mode.displayName}')
      ..writeln('Map this package to your provider as:')
      ..writeln('- systemPrompt → primary system/instruction channel')
      ..writeln('- developerPrompt → secondary/tooling channel if available')
      ..writeln('- conversationConstraints → hard session constraints')
      ..writeln('- teachingRules → pedagogy rules')
      ..writeln('- successCriteria → evaluation checklist')
      ..writeln('- followUpStrategy → closing move')
      ..writeln()
      ..writeln('NOTEBOOK SAVE PROTOCOL (required when learner asks to save a word):')
      ..writeln(
        'Emit exactly this machine block (JSON on one or more lines), then a short Russian confirmation:',
      )
      ..writeln('<<<NOTEBOOK_SAVE>>>')
      ..writeln(
        '{"word":"небоскрёб","translation":"…","examples":["…","…"]}',
      )
      ..writeln('<<<END_NOTEBOOK_SAVE>>>')
      ..writeln(
        'Rules: word = Russian lemma; translation = clear gloss; '
        'examples = 2 short natural Russian sentences using the word. '
        'Do not put the JSON markers in normal chat unless saving.',
      )
      ..writeln()
      ..writeln('Conversation constraints:');
    for (final item in constraints) {
      buffer.writeln('- $item');
    }
    if (request.conversationContext.recentTurns.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('Recent turns:');
      for (final turn in request.conversationContext.recentTurns) {
        buffer.writeln('- $turn');
      }
    }
    return buffer.toString().trimRight();
  }
}
