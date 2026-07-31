import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/misc_enums.dart';

/// App-wide preferences persisted locally.
class AppSettings extends Equatable {
  const AppSettings({
    required this.id,
    required this.updatedAt,
    this.themePreference = ThemePreference.light,
    this.interfaceLanguage = AppLanguage.ru,
    this.hapticsEnabled = true,
    this.soundEnabled = true,
    this.dailyReminderEnabled = false,
    this.dailyReminderHour = 9,
    this.dailyReminderMinute = 0,
    this.autoSaveExpressions = true,
    this.showCoachHints = true,
  });

  final String id;
  final ThemePreference themePreference;
  final AppLanguage interfaceLanguage;
  final bool hapticsEnabled;
  final bool soundEnabled;
  final bool dailyReminderEnabled;
  final int dailyReminderHour;
  final int dailyReminderMinute;
  final bool autoSaveExpressions;
  final bool showCoachHints;
  final DateTime updatedAt;

  AppSettings copyWith({
    ThemePreference? themePreference,
    AppLanguage? interfaceLanguage,
    bool? hapticsEnabled,
    bool? soundEnabled,
    bool? dailyReminderEnabled,
    int? dailyReminderHour,
    int? dailyReminderMinute,
    bool? autoSaveExpressions,
    bool? showCoachHints,
    DateTime? updatedAt,
  }) {
    return AppSettings(
      id: id,
      themePreference: themePreference ?? this.themePreference,
      interfaceLanguage: interfaceLanguage ?? this.interfaceLanguage,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      dailyReminderEnabled:
          dailyReminderEnabled ?? this.dailyReminderEnabled,
      dailyReminderHour: dailyReminderHour ?? this.dailyReminderHour,
      dailyReminderMinute: dailyReminderMinute ?? this.dailyReminderMinute,
      autoSaveExpressions: autoSaveExpressions ?? this.autoSaveExpressions,
      showCoachHints: showCoachHints ?? this.showCoachHints,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        themePreference,
        interfaceLanguage,
        hapticsEnabled,
        soundEnabled,
        dailyReminderEnabled,
        dailyReminderHour,
        dailyReminderMinute,
        autoSaveExpressions,
        showCoachHints,
        updatedAt,
      ];
}
