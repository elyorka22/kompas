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
    this.prompt,
    this.speakingSeconds = 0,
    this.messageCount = 0,
  });

  final String id;
  final String userId;
  final SessionMode mode;
  final SessionStatus status;
  final String title;
  final String? prompt;
  final String? targetSkillId;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final int speakingSeconds;
  final int messageCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  ConversationSession copyWith({
    SessionMode? mode,
    SessionStatus? status,
    String? title,
    String? prompt,
    String? targetSkillId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? speakingSeconds,
    int? messageCount,
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
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      speakingSeconds: speakingSeconds ?? this.speakingSeconds,
      messageCount: messageCount ?? this.messageCount,
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
        startedAt,
        endedAt,
        speakingSeconds,
        messageCount,
        createdAt,
        updatedAt,
      ];
}
