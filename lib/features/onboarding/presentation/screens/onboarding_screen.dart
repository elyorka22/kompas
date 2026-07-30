import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/components/compass_primary_button.dart';
import 'package:kompas/design_system/icons/compass_mark.dart';
import 'package:kompas/design_system/motion/compass_motion.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/navigation/app_routes.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _nameController = TextEditingController();
  AppLanguage _native = AppLanguage.ru;
  AppLanguage _target = AppLanguage.en;
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
      ),
    );
    if (!mounted) return;
    result.fold(
      onSuccess: (_) {
        ref.invalidate(activeUserProvider);
        context.go(AppRoutes.home);
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
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: CompassMotion.page,
          curve: CompassMotion.standard,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 16),
                child: child,
              ),
            );
          },
          child: ListView(
            padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
            children: [
              const SizedBox(height: CompassSpacing.xl),
              const CompassMark(size: 64),
              const SizedBox(height: CompassSpacing.lg),
              Text(AppConstants.appName, style: text.displaySmall),
              const SizedBox(height: CompassSpacing.sm),
              Text(
                'Become a fluent speaker through conversation, storytelling and daily practice.',
                style: text.bodyLarge,
              ),
              const SizedBox(height: CompassSpacing.xl),
              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Your name',
                ),
              ),
              const SizedBox(height: CompassSpacing.md),
              Text('I speak', style: text.titleMedium),
              const SizedBox(height: CompassSpacing.xs),
              DropdownButtonFormField<AppLanguage>(
                value: _native,
                items: AppLanguage.values
                    .map(
                      (language) => DropdownMenuItem(
                        value: language,
                        child: Text(language.nativeName),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _native = value);
                },
              ),
              const SizedBox(height: CompassSpacing.md),
              Text('I want to speak', style: text.titleMedium),
              const SizedBox(height: CompassSpacing.xs),
              DropdownButtonFormField<AppLanguage>(
                value: _target,
                items: AppLanguage.values
                    .map(
                      (language) => DropdownMenuItem(
                        value: language,
                        child: Text(language.englishName),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _target = value);
                },
              ),
              if (_error != null) ...[
                const SizedBox(height: CompassSpacing.md),
                Text(
                  _error!,
                  style: text.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
              const SizedBox(height: CompassSpacing.xl),
              CompassPrimaryButton(
                label: _saving ? 'Setting up…' : 'Start practicing',
                onPressed: _saving ? null : _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
