import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// A speaking practice unit owned by Compass Engine.
class ConversationSession extends Equatable {
  const ConversationSession({
    required this.id,
    required this.userId,
    required this.mode,
    required this.status,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.startedAt,
    this.endedAt,
    this.targetSkillId,
    this.currentExerciseId,
    this.prompt,
    this.speakingSeconds = 0,
    this.messageCount = 0,
    this.exercisesCompleted = 0,
  });

  final String id;
  final String userId;
  final PracticeMode mode;
  final SessionStatus status;
  final String title;
  final String? prompt;
  final String? targetSkillId;
  final String? currentExerciseId;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final int speakingSeconds;
  final int messageCount;
  final int exercisesCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConversationSession copyWith({
    PracticeMode? mode,
    SessionStatus? status,
    String? title,
    String? prompt,
    String? targetSkillId,
    String? currentExerciseId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? speakingSeconds,
    int? messageCount,
    int? exercisesCompleted,
    DateTime? updatedAt,
  }) {
    return ConversationSession(
      id: id,
      userId: userId,
      mode: mode ?? this.mode,
      status: status ?? this.status,
      title: title ?? this.title,
      prompt: prompt ?? this.prompt,
      targetSkillId: targetSkillId ?? this.targetSkillId,
      currentExerciseId: currentExerciseId ?? this.currentExerciseId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      speakingSeconds: speakingSeconds ?? this.speakingSeconds,
      messageCount: messageCount ?? this.messageCount,
      exercisesCompleted: exercisesCompleted ?? this.exercisesCompleted,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        mode,
        status,
        title,
        prompt,
        targetSkillId,
        currentExerciseId,
        startedAt,
        endedAt,
        speakingSeconds,
        messageCount,
        exercisesCompleted,
        createdAt,
        updatedAt,
      ];
}
