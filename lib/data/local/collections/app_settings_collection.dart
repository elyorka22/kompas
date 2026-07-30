import 'package:isar/isar.dart';

part 'app_settings_collection.g.dart';

@collection
class AppSettingsCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String domainId;

  late String themePreference;
  late String interfaceLanguageCode;
  late bool hapticsEnabled;
  late bool soundEnabled;
  late bool dailyReminderEnabled;
  late int dailyReminderHour;
  late int dailyReminderMinute;
  late bool autoSaveExpressions;
  late bool showCoachHints;
  late DateTime updatedAt;
}
