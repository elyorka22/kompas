import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/components/compass_scaffold.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/domain/enums/misc_enums.dart';
import 'package:kompas/features/settings/providers/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final text = Theme.of(context).textTheme;

    return CompassScaffold(
      title: 'Settings',
      body: settings.when(
        data: (value) => ListView(
          padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
          children: [
            CompassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Appearance', style: text.titleLarge),
                  const SizedBox(height: CompassSpacing.md),
                  SegmentedButton<ThemePreference>(
                    segments: const [
                      ButtonSegment(
                        value: ThemePreference.system,
                        label: Text('System'),
                      ),
                      ButtonSegment(
                        value: ThemePreference.light,
                        label: Text('Light'),
                      ),
                      ButtonSegment(
                        value: ThemePreference.dark,
                        label: Text('Dark'),
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
                  Text('Practice', style: text.titleLarge),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Coach hints'),
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
                    title: const Text('Auto-save expressions'),
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
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
      ),
    );
  }
}
