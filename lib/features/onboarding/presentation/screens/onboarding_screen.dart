import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/features/settings/providers/settings_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/navigation/app_routes.dart';

const _practiceMinutes = <int>[5, 10, 15, 20, 30];

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  final _nameController = TextEditingController();

  int _page = 0;
  AppLanguage _native = AppLanguage.ru;
  AppLanguage _target = AppLanguage.ru;
  String _goalKey = KompasL10n.goalKeyWork;
  int _minutes = 10;
  bool _reminders = true;
  bool _saving = false;
  String? _error;

  static const _totalPages = 5;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    setState(() => _page = page);
    _pageController.animateToPage(
      page,
      duration: CompassMotion.page,
      curve: CompassMotion.standard,
    );
  }

  Future<void> _setInterfaceLanguage(AppLanguage language) async {
    final settings = await ref.read(appSettingsProvider.future);
    final next = settings.copyWith(
      interfaceLanguage: InterfaceLanguages.normalize(language),
      updatedAt: DateTime.now().toUtc(),
    );
    await ref.read(updateSettingsProvider)(next);
    ref.invalidate(appSettingsProvider);
  }

  Future<void> _submit() async {
    setState(() {
      _saving = true;
      _error = null;
    });
    final result = await ref.read(completeOnboardingProvider)(
      CompleteOnboardingParams(
        displayName: _nameController.text,
        nativeLanguage: _native,
        targetLanguage: _target,
        learningGoal: _goalKey,
        dailySpeakingGoalMinutes: _minutes,
        dailyReminderEnabled: _reminders,
        dailyReminderHour: 9,
      ),
    );
    if (!mounted) return;
    result.fold(
      onSuccess: (_) {
        ref.invalidate(activeUserProvider);
        context.go(AppRoutes.welcomeMission);
      },
      onFailure: (failure) {
        setState(() {
          _saving = false;
          _error = failure.message;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = KompasL10n.of(context);
    final interfaceLanguage = ref.watch(interfaceLanguageProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CompassAtmosphere(
        child: SafeArea(
          child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                CompassSpacing.screenHorizontal,
                CompassSpacing.md,
                CompassSpacing.screenHorizontal,
                0,
              ),
              child: Column(
                children: [
                  _StepIndicator(current: _page, total: _totalPages),
                  const SizedBox(height: CompassSpacing.sm),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SegmentedButton<AppLanguage>(
                      style: const ButtonStyle(
                        visualDensity: VisualDensity.compact,
                      ),
                      segments: [
                        for (final language in InterfaceLanguages.options)
                          ButtonSegment(
                            value: language,
                            label: Text(language.nativeName),
                          ),
                      ],
                      selected: {interfaceLanguage},
                      onSelectionChanged: (selection) {
                        _setInterfaceLanguage(selection.first);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) => setState(() => _page = value),
                children: [
                  _IntroPage(
                    kind: CompassIllustrationKind.orbit,
                    title: l10n.appName,
                    body: l10n.onboardingPhilosophy,
                    actionLabel: l10n.continueLabel,
                    onAction: () => _goTo(1),
                  ),
                  _IntroPage(
                    kind: CompassIllustrationKind.path,
                    title: l10n.onboardingSpeakReflect,
                    body: l10n.onboardingSpeakReflectBody,
                    actionLabel: l10n.continueLabel,
                    onBack: () => _goTo(0),
                    onAction: () => _goTo(2),
                  ),
                  _IntroPage(
                    kind: CompassIllustrationKind.horizon,
                    title: l10n.onboardingCoachNotGame,
                    body: l10n.onboardingCoachNotGameBody,
                    actionLabel: l10n.createProfile,
                    onBack: () => _goTo(1),
                    onAction: () => _goTo(3),
                  ),
                  _ProfilePage(
                    nameController: _nameController,
                    native: _native,
                    target: _target,
                    onNative: (value) => setState(() => _native = value),
                    onTarget: (value) => setState(() => _target = value),
                    onBack: () => _goTo(2),
                    onNext: () {
                      if (_nameController.text.trim().isEmpty) {
                        setState(() => _error = l10n.pleaseEnterName);
                        return;
                      }
                      setState(() => _error = null);
                      _goTo(4);
                    },
                    error: _page == 3 ? _error : null,
                  ),
                  _PreferencesPage(
                    goalKey: _goalKey,
                    minutes: _minutes,
                    reminders: _reminders,
                    saving: _saving,
                    error: _page == 4 ? _error : null,
                    onGoal: (value) => setState(() => _goalKey = value),
                    onMinutes: (value) => setState(() => _minutes = value),
                    onReminders: (value) => setState(() => _reminders = value),
                    onBack: () => _goTo(3),
                    onSubmit: _saving ? null : _submit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        for (var i = 0; i < total; i++) ...[
          Expanded(
            child: AnimatedContainer(
              duration: CompassMotion.fast,
              height: 4,
              decoration: BoxDecoration(
                gradient: i <= current
                    ? const LinearGradient(
                        colors: [
                          CompassColors.compassBright,
                          CompassColors.compass,
                        ],
                      )
                    : null,
                color: i <= current
                    ? null
                    : scheme.outline.withOpacity(0.45),
                borderRadius: BorderRadius.circular(CompassRadii.pill),
              ),
            ),
          ),
          if (i != total - 1) const SizedBox(width: 6),
        ],
      ],
    );
  }
}

class _IntroPage extends StatelessWidget {
  const _IntroPage({
    required this.kind,
    required this.title,
    required this.body,
    required this.actionLabel,
    required this.onAction,
    this.onBack,
  });

  final CompassIllustrationKind kind;
  final String title;
  final String body;
  final String actionLabel;
  final VoidCallback onAction;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = KompasL10n.of(context);
    return CompassOnboardingTemplate(
      visual: CompassAppear(
        child: CompassIllustration(kind: kind, height: 180),
      ),
      title: Text(title, style: text.displaySmall),
      body: Text(body, style: text.bodyLarge),
      actions: Column(
        children: [
          CompassPrimaryButton(label: actionLabel, onPressed: onAction),
          if (onBack != null) ...[
            const SizedBox(height: CompassSpacing.sm),
            CompassGhostButton(label: l10n.back, onPressed: onBack),
          ],
        ],
      ),
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({
    required this.nameController,
    required this.native,
    required this.target,
    required this.onNative,
    required this.onTarget,
    required this.onBack,
    required this.onNext,
    this.error,
  });

  final TextEditingController nameController;
  final AppLanguage native;
  final AppLanguage target;
  final ValueChanged<AppLanguage> onNative;
  final ValueChanged<AppLanguage> onTarget;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = KompasL10n.of(context);
    return CompassOnboardingTemplate(
      visual: const CompassMark(size: 56),
      title: Text(l10n.yourProfile, style: text.headlineLarge),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CompassInput(
            controller: nameController,
            label: l10n.nameLabel,
            hint: l10n.nameHint,
          ),
          const SizedBox(height: CompassSpacing.md),
          Text(l10n.iSpeak, style: text.titleMedium),
          const SizedBox(height: CompassSpacing.xs),
          DropdownButtonFormField<AppLanguage>(
            value: native,
            items: [
              for (final language in AppLanguage.values)
                DropdownMenuItem(
                  value: language,
                  child: Text(language.nativeName),
                ),
            ],
            onChanged: (value) {
              if (value != null) onNative(value);
            },
          ),
          const SizedBox(height: CompassSpacing.md),
          Text(l10n.iWantToSpeak, style: text.titleMedium),
          const SizedBox(height: CompassSpacing.xs),
          DropdownButtonFormField<AppLanguage>(
            value: target,
            items: [
              for (final language in AppLanguage.values)
                DropdownMenuItem(
                  value: language,
                  child: Text(language.englishName),
                ),
            ],
            onChanged: (value) {
              if (value != null) onTarget(value);
            },
          ),
          if (error != null) ...[
            const SizedBox(height: CompassSpacing.md),
            Text(
              error!,
              style: text.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ],
      ),
      actions: Column(
        children: [
          CompassPrimaryButton(label: l10n.continueLabel, onPressed: onNext),
          const SizedBox(height: CompassSpacing.sm),
          CompassGhostButton(label: l10n.back, onPressed: onBack),
        ],
      ),
    );
  }
}

class _PreferencesPage extends StatelessWidget {
  const _PreferencesPage({
    required this.goalKey,
    required this.minutes,
    required this.reminders,
    required this.saving,
    required this.onGoal,
    required this.onMinutes,
    required this.onReminders,
    required this.onBack,
    required this.onSubmit,
    this.error,
  });

  final String goalKey;
  final int minutes;
  final bool reminders;
  final bool saving;
  final ValueChanged<String> onGoal;
  final ValueChanged<int> onMinutes;
  final ValueChanged<bool> onReminders;
  final VoidCallback onBack;
  final VoidCallback? onSubmit;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = KompasL10n.of(context);
    return CompassOnboardingTemplate(
      visual: const CompassWidget(size: 72, animate: true),
      title: Text(l10n.yourRhythm, style: text.headlineLarge),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.learningGoal, style: text.titleMedium),
          const SizedBox(height: CompassSpacing.xs),
          Wrap(
            spacing: CompassSpacing.xs,
            runSpacing: CompassSpacing.xs,
            children: [
              for (final item in l10n.learningGoals)
                ChoiceChip(
                  label: Text(item.label),
                  selected: goalKey == item.key,
                  onSelected: (_) => onGoal(item.key),
                ),
            ],
          ),
          const SizedBox(height: CompassSpacing.lg),
          Text(l10n.dailyPracticeTime, style: text.titleMedium),
          const SizedBox(height: CompassSpacing.xs),
          Wrap(
            spacing: CompassSpacing.xs,
            children: [
              for (final value in _practiceMinutes)
                ChoiceChip(
                  label: Text(l10n.minutesLabel(value)),
                  selected: minutes == value,
                  onSelected: (_) => onMinutes(value),
                ),
            ],
          ),
          const SizedBox(height: CompassSpacing.lg),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.dailyReminder),
            subtitle: Text(l10n.dailyReminderSubtitle),
            value: reminders,
            onChanged: onReminders,
          ),
          if (error != null) ...[
            const SizedBox(height: CompassSpacing.md),
            Text(
              error!,
              style: text.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ],
      ),
      actions: Column(
        children: [
          CompassPrimaryButton(
            label: saving ? l10n.preparingCompass : l10n.beginJourney,
            onPressed: onSubmit,
          ),
          const SizedBox(height: CompassSpacing.sm),
          CompassGhostButton(label: l10n.back, onPressed: onBack),
        ],
      ),
    );
  }
}
