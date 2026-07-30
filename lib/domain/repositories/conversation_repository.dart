import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/conversation_message.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/enums/session_enums.dart';

abstract class ConversationRepository {
  Future<Result<ConversationSession>> createSession(ConversationSession session);
  Future<Result<ConversationSession>> updateSession(ConversationSession session);
  Future<Result<ConversationSession>> getSession(String id);
  Future<Result<List<ConversationSession>>> listSessions({
    required String userId,
    SessionStatus? status,
    int limit = 50,
  });
  Future<Result<ConversationMessage>> addMessage(ConversationMessage message);
  Future<Result<List<ConversationMessage>>> listMessages(String sessionId);
  Future<Result<void>> deleteSession(String id);
}
