import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/conversation_message_collection.dart';
import 'package:kompas/data/local/collections/conversation_session_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/conversation_message.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/domain/repositories/conversation_repository.dart';

class IsarConversationRepository implements ConversationRepository {
  IsarConversationRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<ConversationSession>> createSession(
    ConversationSession session,
  ) async {
    return _putSession(session);
  }

  @override
  Future<Result<ConversationSession>> updateSession(
    ConversationSession session,
  ) async {
    return _putSession(session);
  }

  Future<Result<ConversationSession>> _putSession(
    ConversationSession session,
  ) async {
    try {
      final existing = await _isar.conversationSessionCollections
          .filter()
          .domainIdEqualTo(session.id)
          .findFirst();
      final mapped =
          EntityMappers.fromSession(session, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.conversationSessionCollections.put(mapped);
      });
      return Success(session);
    } catch (error) {
      return Err(StorageFailure('Failed to save session', cause: error));
    }
  }

  @override
  Future<Result<ConversationSession>> getSession(String id) async {
    try {
      final collection = await _isar.conversationSessionCollections
          .filter()
          .domainIdEqualTo(id)
          .findFirst();
      if (collection == null) {
        return const Err(NotFoundFailure('Session not found'));
      }
      return Success(EntityMappers.toSession(collection));
    } catch (error) {
      return Err(StorageFailure('Failed to load session', cause: error));
    }
  }

  @override
  Future<Result<List<ConversationSession>>> listSessions({
    required String userId,
    SessionStatus? status,
    int limit = 50,
  }) async {
    try {
      final query = _isar.conversationSessionCollections
          .filter()
          .userIdEqualTo(userId);
      final all = await query.sortByUpdatedAtDesc().findAll();
      final filtered = status == null
          ? all
          : all.where((item) => item.status == status.name).toList();
      return Success(
        filtered.take(limit).map(EntityMappers.toSession).toList(),
      );
    } catch (error) {
      return Err(StorageFailure('Failed to list sessions', cause: error));
    }
  }

  @override
  Future<Result<ConversationMessage>> addMessage(
    ConversationMessage message,
  ) async {
    try {
      final existing = await _isar.conversationMessageCollections
          .filter()
          .domainIdEqualTo(message.id)
          .findFirst();
      final mapped =
          EntityMappers.fromMessage(message, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.conversationMessageCollections.put(mapped);
      });
      return Success(message);
    } catch (error) {
      return Err(StorageFailure('Failed to save message', cause: error));
    }
  }

  @override
  Future<Result<List<ConversationMessage>>> listMessages(
    String sessionId,
  ) async {
    try {
      final items = await _isar.conversationMessageCollections
          .filter()
          .sessionIdEqualTo(sessionId)
          .sortByCreatedAt()
          .findAll();
      return Success(items.map(EntityMappers.toMessage).toList());
    } catch (error) {
      return Err(StorageFailure('Failed to list messages', cause: error));
    }
  }

  @override
  Future<Result<void>> deleteSession(String id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.conversationSessionCollections
            .filter()
            .domainIdEqualTo(id)
            .deleteAll();
        await _isar.conversationMessageCollections
            .filter()
            .sessionIdEqualTo(id)
            .deleteAll();
      });
      return const Success(null);
    } catch (error) {
      return Err(StorageFailure('Failed to delete session', cause: error));
    }
  }
}
