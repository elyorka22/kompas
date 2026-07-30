import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/navigation/app_routes.dart';

const _goals = <String>[
  'Speak confidently at work',
  'Travel with ease',
  'Everyday conversations',
  'Study and academic speech',
];

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
  AppLanguage _target = AppLanguage.en;
  String _goal = _goals.first;
  int _minutes = 10;
  bool _reminders = true;
  bool _saving = false;
  String? _error;

  static const _totalPages = 5; // 3 intro + profile + preferences

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
        learningGoal: _goal,
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                CompassSpacing.screenHorizontal,
                CompassSpacing.md,
                CompassSpacing.screenHorizontal,
                0,
              ),
              child: _StepIndicator(current: _page, total: _totalPages),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) => setState(() => _page = value),
                children: [
                  _IntroPage(
                    kind: CompassIllustrationKind.orbit,
                    title: AppConstants.appName,
                    body:
                        'Compass doesn’t teach for you.\nCompass guides your journey.',
                    actionLabel: 'Continue',
                    onAction: () => _goTo(1),
                  ),
                  _IntroPage(
                    kind: CompassIllustrationKind.path,
                    title: 'Speak. Reflect. Grow.',
                    body:
                        'Daily missions, skill progress, and memory — all offline, all intentional.',
                    actionLabel: 'Continue',
                    onBack: () => _goTo(0),
                    onAction: () => _goTo(2),
                  ),
                  _IntroPage(
                    kind: CompassIllustrationKind.horizon,
                    title: 'A coach, not a game.',
                    body:
                        'Calm guidance. Real conversation practice. Premium focus — never childish drills.',
                    actionLabel: 'Create profile',
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
                        setState(() => _error = 'Please enter your name');
                        return;
                      }
                      setState(() => _error = null);
                      _goTo(4);
                    },
                    error: _page == 3 ? _error : null,
                  ),
                  _PreferencesPage(
                    goal: _goal,
                    minutes: _minutes,
                    reminders: _reminders,
                    saving: _saving,
                    error: _page == 4 ? _error : null,
                    onGoal: (value) => setState(() => _goal = value),
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
              height: 3,
              decoration: BoxDecoration(
                color: i <= current
                    ? scheme.primary
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
            CompassGhostButton(label: 'Back', onPressed: onBack),
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
    return CompassOnboardingTemplate(
      visual: const CompassMark(size: 56),
      title: Text('Your profile', style: text.headlineLarge),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CompassInput(
            controller: nameController,
            label: 'Name',
            hint: 'How should Compass address you?',
          ),
          const SizedBox(height: CompassSpacing.md),
          Text('I speak', style: text.titleMedium),
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
          Text('I want to speak', style: text.titleMedium),
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
          CompassPrimaryButton(label: 'Continue', onPressed: onNext),
          const SizedBox(height: CompassSpacing.sm),
          CompassGhostButton(label: 'Back', onPressed: onBack),
        ],
      ),
    );
  }
}

class _PreferencesPage extends StatelessWidget {
  const _PreferencesPage({
    required this.goal,
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

  final String goal;
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
    return CompassOnboardingTemplate(
      visual: const CompassWidget(size: 72, animate: true),
      title: Text('Your rhythm', style: text.headlineLarge),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Learning goal', style: text.titleMedium),
          const SizedBox(height: CompassSpacing.xs),
          Wrap(
            spacing: CompassSpacing.xs,
            runSpacing: CompassSpacing.xs,
            children: [
              for (final item in _goals)
                ChoiceChip(
                  label: Text(item),
                  selected: goal == item,
                  onSelected: (_) => onGoal(item),
                ),
            ],
          ),
          const SizedBox(height: CompassSpacing.lg),
          Text('Daily practice time', style: text.titleMedium),
          const SizedBox(height: CompassSpacing.xs),
          Wrap(
            spacing: CompassSpacing.xs,
            children: [
              for (final value in _practiceMinutes)
                ChoiceChip(
                  label: Text('$value min'),
                  selected: minutes == value,
                  onSelected: (_) => onMinutes(value),
                ),
            ],
          ),
          const SizedBox(height: CompassSpacing.lg),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Daily practice reminder'),
            subtitle: const Text('A quiet nudge at 09:00'),
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
            label: saving ? 'Preparing Compass…' : 'Begin journey',
            onPressed: onSubmit,
          ),
          const SizedBox(height: CompassSpacing.sm),
          CompassGhostButton(label: 'Back', onPressed: onBack),
        ],
      ),
    );
  }
}
