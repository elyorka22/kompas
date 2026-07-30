import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/prompt_mode.dart';

/// Structured sections every generated prompt must contain.
class PromptSections extends Equatable {
  const PromptSections({
    required this.role,
    required this.mission,
    required this.teachingStrategy,
    required this.memorySummary,
    required this.currentGoal,
    required this.forbiddenBehaviors,
    required this.expectedBehaviors,
    required this.conversationStyle,
    required this.stopConditions,
  });

  final String role;
  final String mission;
  final String teachingStrategy;
  final String memorySummary;
  final String currentGoal;
  final List<String> forbiddenBehaviors;
  final List<String> expectedBehaviors;
  final String conversationStyle;
  final List<String> stopConditions;

  /// Renders sections as plain labeled text (provider-agnostic).
  String toLabeledBlock() {
    final buffer = StringBuffer()
      ..writeln('## Role')
      ..writeln(role)
      ..writeln()
      ..writeln('## Mission')
      ..writeln(mission)
      ..writeln()
      ..writeln('## Teaching Strategy')
      ..writeln(teachingStrategy)
      ..writeln()
      ..writeln('## Memory Summary')
      ..writeln(memorySummary)
      ..writeln()
      ..writeln('## Current Goal')
      ..writeln(currentGoal)
      ..writeln()
      ..writeln('## Forbidden Behaviors');
    for (final item in forbiddenBehaviors) {
      buffer.writeln('- $item');
    }
    buffer
      ..writeln()
      ..writeln('## Expected Behaviors');
    for (final item in expectedBehaviors) {
      buffer.writeln('- $item');
    }
    buffer
      ..writeln()
      ..writeln('## Conversation Style')
      ..writeln(conversationStyle)
      ..writeln()
      ..writeln('## Stop Conditions');
    for (final item in stopConditions) {
      buffer.writeln('- $item');
    }
    return buffer.toString().trimRight();
  }

  @override
  List<Object?> get props => [
        role,
        mission,
        teachingStrategy,
        memorySummary,
        currentGoal,
        forbiddenBehaviors,
        expectedBehaviors,
        conversationStyle,
        stopConditions,
      ];
}

/// Provider-independent prompt package for any future LLM adapter.
class PromptBundle extends Equatable {
  const PromptBundle({
    required this.mode,
    required this.systemPrompt,
    required this.developerPrompt,
    required this.conversationConstraints,
    required this.teachingRules,
    required this.successCriteria,
    required this.followUpStrategy,
    required this.sections,
  });

  final PromptMode mode;

  /// Primary instruction block for the model (sections assembled).
  final String systemPrompt;

  /// Secondary instructions for tooling / orchestration layers.
  final String developerPrompt;

  final List<String> conversationConstraints;
  final List<String> teachingRules;
  final List<String> successCriteria;
  final String followUpStrategy;
  final PromptSections sections;

  @override
  List<Object?> get props => [
        mode,
        systemPrompt,
        developerPrompt,
        conversationConstraints,
        teachingRules,
        successCriteria,
        followUpStrategy,
        sections,
      ];
}
