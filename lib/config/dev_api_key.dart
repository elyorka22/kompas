/// Personal DeepSeek API config for on-device calls (no backend server).
///
/// Kompas is for personal use: the release APK talks to DeepSeek from the phone.
/// Anyone with the APK can extract the key — keep the repo private.
abstract final class DevApiKey {
  static const value = 'sk-ae339cb66c314cbda05df4039845408a';

  /// DeepSeek OpenAI-compatible API root (no trailing slash).
  static const baseUrl = 'https://api.deepseek.com';

  /// Stable chat model. Alternatives: deepseek-chat, deepseek-reasoner.
  static const model = 'deepseek-chat';
}
