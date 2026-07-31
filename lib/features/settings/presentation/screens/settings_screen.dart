import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/core_providers.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/misc_enums.dart';
import 'package:kompas/features/ai_adapter/data/stored_key_ai_adapter.dart';
import 'package:kompas/features/settings/providers/settings_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/providers/voice_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _apiKeyController = TextEditingController();
  bool _obscureKey = true;
  bool _loadedKey = false;

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  Future<void> _loadKey() async {
    if (_loadedKey) return;
    final key = await ref.read(aiApiKeyStoreProvider).read();
    if (!mounted) return;
    setState(() {
      _apiKeyController.text = key ?? '';
      _loadedKey = true;
    });
  }

  Future<void> _saveKey() async {
    final l10n = KompasL10n.of(context);
    await ref.read(aiApiKeyStoreProvider).write(_apiKeyController.text);
    final adapter = ref.read(aiAdapterProvider);
    if (adapter is StoredKeyAiAdapter) {
      await adapter.refreshAvailability();
    }
    if (!mounted) return;
    CompassSnackbars.show(context, message: l10n.apiKeySaved);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    _loadKey();

    return CompassScaffold(
      title: l10n.settings,
      body: settings.when(
        data: (value) {
          final interfaceLanguage =
              InterfaceLanguages.normalize(value.interfaceLanguage);
          return ListView(
            padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
            children: [
              CompassQuietSurface(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.aiSection, style: text.titleLarge),
                    const SizedBox(height: CompassSpacing.sm),
                    Text(
                      l10n.openaiApiKeyHint,
                      style: text.bodySmall,
                    ),
                    const SizedBox(height: CompassSpacing.md),
                    TextField(
                      controller: _apiKeyController,
                      obscureText: _obscureKey,
                      decoration: InputDecoration(
                        labelText: l10n.openaiApiKey,
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => _obscureKey = !_obscureKey),
                          icon: Icon(
                            _obscureKey
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: CompassSpacing.md),
                    CompassPrimaryButton(
                      label: l10n.saveApiKey,
                      onPressed: _saveKey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CompassSpacing.md),
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
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.voiceAutoSend),
                      subtitle: Text(l10n.voiceAutoSendSubtitle),
                      value: ref.watch(voiceAutoSendProvider),
                      onChanged: (enabled) async {
                        await ref
                            .read(voiceAutoSendProvider.notifier)
                            .setEnabled(enabled);
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
