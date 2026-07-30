import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/app_settings.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/misc_enums.dart';
import 'package:kompas/l10n/kompas_l10n.dart';

final appSettingsProvider = FutureProvider<AppSettings>((ref) async {
  final result = await ref.watch(getSettingsProvider)(const NoParams());
  return result.valueOrNull ??
      AppSettings(id: 'app_settings', updatedAt: DateTime.now().toUtc());
});

final themePreferenceProvider = Provider<ThemePreference>((ref) {
  return ref.watch(appSettingsProvider).maybeWhen(
        data: (settings) => settings.themePreference,
        orElse: () => ThemePreference.system,
      );
});

final interfaceLanguageProvider = Provider<AppLanguage>((ref) {
  return ref.watch(appSettingsProvider).maybeWhen(
        data: (settings) =>
            InterfaceLanguages.normalize(settings.interfaceLanguage),
        orElse: () => AppLanguage.ru,
      );
});
