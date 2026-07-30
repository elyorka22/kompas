/// Global product constants that must stay stable across features.
abstract final class AppConstants {
  static const String appName = 'Компас';
  static const String appNameLatin = 'Kompas';
  static const String appVersion = '0.1.0';

  /// Local Isar database name. Bump schemaVersion when collections change.
  static const String databaseName = 'kompas';
  static const int databaseSchemaVersion = 2;

  /// Default daily speaking target used before the user customizes goals.
  static const int defaultDailySpeakingMinutes = 10;
  static const int defaultDailyMissionCount = 3;

  /// How many recent exercises are blocked from immediate repeat.
  static const int exerciseRepeatBlockSize = 5;

  /// Exercises queued in a generated daily plan.
  static const int dailyPlanExerciseCount = 4;

  /// Memory Engine review batch size for a single practice session.
  static const int defaultReviewBatchSize = 8;
}
