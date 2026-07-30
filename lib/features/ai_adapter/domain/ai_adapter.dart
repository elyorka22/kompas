import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// Future LLM / remote coach boundary.
///
/// Backend will only proxy AI requests. Everything else stays local.
/// v0.1 ships [OfflineNoopAiAdapter] so the rest of the product can compile
/// and run without a network dependency.
abstract class AiAdapter {
  Future<Result<AiCoachReply>> generateCoachReply(AiCoachRequest request);

  Future<Result<List<String>>> suggestExpressions({
    required String transcript,
    required String targetLanguageCode,
  });

  bool get isAvailable;
}

class AiCoachRequest {
  const AiCoachRequest({
    required this.sessionId,
    required this.mode,
    required this.targetLanguageCode,
    required this.nativeLanguageCode,
    required this.recentMessages,
    this.userUtterance,
  });

  final String sessionId;
  final SessionMode mode;
  final String targetLanguageCode;
  final String nativeLanguageCode;
  final List<String> recentMessages;
  final String? userUtterance;
}

class AiCoachReply {
  const AiCoachReply({
    required this.content,
    this.suggestedExpressions = const [],
  });

  final String content;
  final List<String> suggestedExpressions;
}

/// Productive no-op for MVP. Returns a clear unsupported failure for LLM calls.
class OfflineNoopAiAdapter implements AiAdapter {
  const OfflineNoopAiAdapter();

  @override
  bool get isAvailable => false;

  @override
  Future<Result<AiCoachReply>> generateCoachReply(
    AiCoachRequest request,
  ) async {
    return const Err(
      UnsupportedFailure(
        'AI coaching is not available in Kompas 0.1. Local Compass Engine guides practice instead.',
      ),
    );
  }

  @override
  Future<Result<List<String>>> suggestExpressions({
    required String transcript,
    required String targetLanguageCode,
  }) async {
    return const Err(
      UnsupportedFailure(
        'AI expression suggestions require a later AI Adapter release.',
      ),
    );
  }
}
