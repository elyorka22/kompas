import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/components/compass_scaffold.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/misc_enums.dart';
import 'package:kompas/features/settings/providers/settings_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;

    return CompassScaffold(
      title: l10n.settings,
      body: settings.when(
        data: (value) {
          final interfaceLanguage =
              InterfaceLanguages.normalize(value.interfaceLanguage);
          return ListView(
            padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
            children: [
              CompassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.appearance, style: text.titleLarge),
                    const SizedBox(height: CompassSpacing.md),
                    SegmentedButton<ThemePreference>(
                      segments: [
                        ButtonSegment(
                          value: ThemePreference.system,
                          label: Text(l10n.themeSystem),
                        ),
                        ButtonSegment(
                          value: ThemePreference.light,
                          label: Text(l10n.themeLight),
                        ),
                        ButtonSegment(
                          value: ThemePreference.dark,
                          label: Text(l10n.themeDark),
                        ),
                      ],
                      selected: {value.themePreference},
                      onSelectionChanged: (selection) async {
                        final next = value.copyWith(
                          themePreference: selection.first,
                          updatedAt: DateTime.now().toUtc(),
                        );
                        await ref.read(updateSettingsProvider)(next);
                        ref.invalidate(appSettingsProvider);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CompassSpacing.md),
              CompassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.interfaceLanguage, style: text.titleLarge),
                    const SizedBox(height: CompassSpacing.md),
                    SegmentedButton<AppLanguage>(
                      segments: [
                        for (final language in InterfaceLanguages.options)
                          ButtonSegment(
                            value: language,
                            label: Text(language.nativeName),
                          ),
                      ],
                      selected: {interfaceLanguage},
                      onSelectionChanged: (selection) async {
                        final next = value.copyWith(
                          interfaceLanguage:
                              InterfaceLanguages.normalize(selection.first),
                          updatedAt: DateTime.now().toUtc(),
                        );
                        await ref.read(updateSettingsProvider)(next);
                        ref.invalidate(appSettingsProvider);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CompassSpacing.md),
              CompassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.practiceSection, style: text.titleLarge),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.coachHints),
                      value: value.showCoachHints,
                      onChanged: (enabled) async {
                        final next = value.copyWith(
                          showCoachHints: enabled,
                          updatedAt: DateTime.now().toUtc(),
                        );
                        await ref.read(updateSettingsProvider)(next);
                        ref.invalidate(appSettingsProvider);
                      },
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.autoSaveExpressions),
                      value: value.autoSaveExpressions,
                      onChanged: (enabled) async {
                        final next = value.copyWith(
                          autoSaveExpressions: enabled,
                          updatedAt: DateTime.now().toUtc(),
                        );
                        await ref.read(updateSettingsProvider)(next);
                        ref.invalidate(appSettingsProvider);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => Center(child: Text(l10n.loading)),
        error: (error, _) => Center(child: Text('$error')),
      ),
    );
  }
}
