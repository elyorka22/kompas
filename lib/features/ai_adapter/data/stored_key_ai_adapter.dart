import 'package:http/http.dart' as http;
import 'package:kompas/config/dev_api_key.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/features/ai_adapter/data/ai_api_key_store.dart';
import 'package:kompas/features/ai_adapter/data/openai_chat_adapter.dart';
import 'package:kompas/features/ai_adapter/domain/ai_adapter.dart';

/// Resolves the API key from prefs / dart-define / embedded [DevApiKey].
class StoredKeyAiAdapter implements AiAdapter {
  StoredKeyAiAdapter(this._store, {http.Client? client})
      : _client = client ?? http.Client(),
        _hasKeyCache = _syncHasEmbeddedKey();

  final AiApiKeyStore _store;
  final http.Client _client;
  bool _hasKeyCache;

  static bool _syncHasEmbeddedKey() {
    if (DevApiKey.value.trim().isNotEmpty) return true;
    if (AiApiKeyStore.dartDefineKey.trim().isNotEmpty) return true;
    return false;
  }

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
    return OpenAiChatAdapter(
      apiKey: key,
      baseUrl: DevApiKey.baseUrl,
      model: DevApiKey.model,
      client: _client,
    );
  }

  @override
  Future<Result<AiCoachReply>> generateCoachReply(
    AiCoachRequest request,
  ) async {
    final adapter = await _delegate();
    if (!adapter.isAvailable) {
      return const Err(
        UnsupportedFailure(
          'AI ключ не найден. Проверьте lib/config/dev_api_key.dart или Настройки.',
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
