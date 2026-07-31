import 'package:kompas/config/dev_api_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Resolves the AI API key for on-device calls (no backend proxy).
///
/// Priority:
/// 1. Value saved in Settings (SharedPreferences)
/// 2. `--dart-define=OPENAI_API_KEY=...`
/// 3. Embedded [DevApiKey] (personal APK builds)
class AiApiKeyStore {
  static const _prefsKey = 'kompas_openai_api_key';

  static const dartDefineKey = String.fromEnvironment(
    'OPENAI_API_KEY',
    defaultValue: '',
  );

  Future<String?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey)?.trim();
    if (saved != null && saved.isNotEmpty) return saved;

    final fromDefine = dartDefineKey.trim();
    if (fromDefine.isNotEmpty) return fromDefine;

    final embedded = DevApiKey.value.trim();
    if (embedded.isNotEmpty) return embedded;

    return null;
  }

  Future<void> write(String? key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = key?.trim() ?? '';
    if (value.isEmpty) {
      await prefs.remove(_prefsKey);
    } else {
      await prefs.setString(_prefsKey, value);
    }
  }

  Future<bool> hasKey() async {
    final key = await read();
    return key != null && key.isNotEmpty;
  }
}
