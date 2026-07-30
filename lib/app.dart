import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/design_system/theme/compass_theme.dart';
import 'package:kompas/domain/enums/misc_enums.dart';
import 'package:kompas/features/settings/providers/settings_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/navigation/app_router.dart';

class KompasApp extends ConsumerWidget {
  const KompasApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themePreference = ref.watch(themePreferenceProvider);
    final interfaceLanguage = ref.watch(interfaceLanguageProvider);
    final locale = InterfaceLanguages.toLocale(interfaceLanguage);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: CompassTheme.light(),
      darkTheme: CompassTheme.dark(),
      themeMode: switch (themePreference) {
        ThemePreference.system => ThemeMode.system,
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
      },
      locale: locale,
      supportedLocales: const [
        Locale('ru'),
        Locale('uz'),
      ],
      localizationsDelegates: const [
        KompasL10nDelegate(),
        FallbackMaterialLocalizationsDelegate(),
        FallbackCupertinoLocalizationsDelegate(),
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
