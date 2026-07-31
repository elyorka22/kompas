/// Personal API key embedded for direct device → AI calls (no backend server).
///
/// Kompas is for personal use: the release APK calls the AI provider from the
/// phone using this key. Anyone with the APK can extract it — acceptable only
/// for a private app / private key.
abstract final class DevApiKey {
  static const value = 'sk-ae339cb66c314cbda05df4039845408a';
}
