import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/conversation_message.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/domain/repositories/conversation_repository.dart';

/// Orchestrates speaking practice sessions.
///
/// Compass Engine is the product brain: it decides session shape, local coach
/// prompts, and how Memory / Speech / Goals attach to a practice unit.
/// It does NOT call an LLM in v0.1.
class CompassEngineService {
  CompassEngineService({
    required ConversationRepository conversationRepository,
  }) : _conversations = conversationRepository;

  final ConversationRepository _conversations;

  Future<Result<ConversationSession>> startSession({
    required String userId,
    required SessionMode mode,
    String? title,
    String? prompt,
    String? targetSkillId,
  }) async {
    final now = DateTime.now().toUtc();
    final session = ConversationSession(
      id: IdGenerator.v4(),
      userId: userId,
      mode: mode,
      status: SessionStatus.active,
      title: title ?? _defaultTitle(mode),
      prompt: prompt ?? _defaultPrompt(mode),
      targetSkillId: targetSkillId,
      startedAt: now,
      createdAt: now,
      updatedAt: now,
    );

    final created = await _conversations.createSession(session);
    if (created.isFailure) return created;

    final coach = ConversationMessage(
      id: IdGenerator.v4(),
      sessionId: session.id,
      role: MessageRole.coach,
      content: session.prompt ?? _defaultPrompt(mode),
      createdAt: now,
    );
    await _conversations.addMessage(coach);

    return Success(session);
  }

  Future<Result<ConversationSession>> completeSession(
    ConversationSession session, {
    required int speakingSeconds,
  }) async {
    final now = DateTime.now().toUtc();
    final completed = session.copyWith(
      status: SessionStatus.completed,
      speakingSeconds: speakingSeconds,
      endedAt: now,
      updatedAt: now,
    );
    return _conversations.updateSession(completed);
  }

  String _defaultTitle(SessionMode mode) {
    return switch (mode) {
      SessionMode.freeTalk => 'Free talk',
      SessionMode.storytelling => 'Storytelling',
      SessionMode.argumentation => 'Argumentation',
      SessionMode.explanation => 'Explanation',
      SessionMode.speakingDrill => 'Speaking drill',
      SessionMode.memoryReview => 'Memory review',
    };
  }

  String _defaultPrompt(SessionMode mode) {
    return switch (mode) {
      SessionMode.freeTalk =>
        'Speak for a few minutes about your day. Focus on clarity, not perfection.',
      SessionMode.storytelling =>
        'Tell a short story with a beginning, middle, and end. Use past tense.',
      SessionMode.argumentation =>
        'Pick a position and defend it with two clear reasons.',
      SessionMode.explanation =>
        'Explain a familiar topic as if teaching a beginner.',
      SessionMode.speakingDrill =>
        'Repeat the target phrases aloud, then use each in your own sentence.',
      SessionMode.memoryReview =>
        'Recall each expression aloud before checking the answer.',
    };
  }
}
