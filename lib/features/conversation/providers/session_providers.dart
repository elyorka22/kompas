import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/core_providers.dart';
import 'package:kompas/domain/entities/conversation_message.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/finished_session_result.dart';

final sessionByIdProvider =
    FutureProvider.family<ConversationSession?, String>((ref, id) async {
  final result = await ref.watch(conversationRepositoryProvider).getSession(id);
  return result.valueOrNull;
});

final sessionMessagesProvider =
    FutureProvider.family<List<ConversationMessage>, String>((ref, id) async {
  final result =
      await ref.watch(conversationRepositoryProvider).listMessages(id);
  return result.valueOrNull ?? const [];
});

/// Holds the latest finished session for the completion screen.
final lastFinishedSessionProvider =
    StateProvider<FinishedSessionResult?>((ref) => null);
