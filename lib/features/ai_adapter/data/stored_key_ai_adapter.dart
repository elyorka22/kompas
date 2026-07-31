import 'package:http/http.dart' as http;
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/features/ai_adapter/data/ai_api_key_store.dart';
import 'package:kompas/features/ai_adapter/data/openai_chat_adapter.dart';
import 'package:kompas/features/ai_adapter/domain/ai_adapter.dart';

/// Resolves the OpenAI key from local storage on every call.
class StoredKeyAiAdapter implements AiAdapter {
  StoredKeyAiAdapter(this._store, {http.Client? client})
      : _client = client ?? http.Client();

  final AiApiKeyStore _store;
  final http.Client _client;
  bool _hasKeyCache = false;

  Future<void> refreshAvailability() async {
    _hasKeyCache = await _store.hasKey();
  }

  @override
  bool get isAvailable => _hasKeyCache;

  Future<AiAdapter> _delegate() async {
    final key = await _store.read();
    if (key == null || key.isEmpty) {
      _hasKeyCache = false;
      return const OfflineNoopAiAdapter();
    }
    _hasKeyCache = true;
    return OpenAiChatAdapter(apiKey: key, client: _client);
  }

  @override
  Future<Result<AiCoachReply>> generateCoachReply(
    AiCoachRequest request,
  ) async {
    final adapter = await _delegate();
    if (!adapter.isAvailable) {
      return const Err(
        UnsupportedFailure(
          'Добавьте OpenAI API ключ в Настройках, чтобы говорить с коучем.',
        ),
      );
    }
    return adapter.generateCoachReply(request);
  }

  @override
  Future<Result<List<String>>> suggestExpressions({
    required String transcript,
    required String targetLanguageCode,
  }) async {
    final adapter = await _delegate();
    return adapter.suggestExpressions(
      transcript: transcript,
      targetLanguageCode: targetLanguageCode,
    );
  }
}
