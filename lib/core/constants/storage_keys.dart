/// Keys for non-Isar ephemeral preferences if needed later.
///
/// Primary persistence is Isar. These keys exist for future SharedPreferences
/// bootstrap flags that must load before the database is ready.
abstract final class StorageKeys {
  static const String hasCompletedOnboarding = 'has_completed_onboarding';
  static const String lastActiveUserId = 'last_active_user_id';
}
