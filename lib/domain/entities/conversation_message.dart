import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// Single turn inside a [ConversationSession].
///
/// In v0.1 coach messages come from local Compass Engine templates,
/// not from an LLM.
class ConversationMessage extends Equatable {
  const ConversationMessage({
    required this.id,
    required this.sessionId,
    required this.role,
    required this.content,
    required this.createdAt,
    this.audioPath,
    this.durationMs,
    this.speechAnalysisId,
  });

  final String id;
  final String sessionId;
  final MessageRole role;
  final String content;
  final String? audioPath;
  final int? durationMs;
  final String? speechAnalysisId;
  final DateTime createdAt;

  ConversationMessage copyWith({
    String? content,
    String? audioPath,
    int? durationMs,
    String? speechAnalysisId,
  }) {
    return ConversationMessage(
      id: id,
      sessionId: sessionId,
      role: role,
      content: content ?? this.content,
      audioPath: audioPath ?? this.audioPath,
      durationMs: durationMs ?? this.durationMs,
      speechAnalysisId: speechAnalysisId ?? this.speechAnalysisId,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        sessionId,
        role,
        content,
        audioPath,
        durationMs,
        speechAnalysisId,
        createdAt,
      ];
}
