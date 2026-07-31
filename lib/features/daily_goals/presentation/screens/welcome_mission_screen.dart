import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/features/daily_goals/providers/daily_goals_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/navigation/app_routes.dart';

/// Shown once after onboarding — first Compass Engine daily mission.
class WelcomeMissionScreen extends ConsumerWidget {
  const WelcomeMissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final missions = ref.watch(todaysMissionsProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CompassAtmosphere(
        child: SafeArea(
          child: CompassAppear(
            child: Padding(
              padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: CompassSpacing.xl),
                  const CompassPulse(child: CompassWidget(size: 72)),
                  const SizedBox(height: CompassSpacing.xl),
                  Text(l10n.firstMissionTitle, style: text.displaySmall),
                  const SizedBox(height: CompassSpacing.md),
                  Text(
                    l10n.firstMissionBody,
                    style: text.bodyLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: CompassSpacing.xl),
                  Expanded(
                    child: missions.when(
                      data: (items) {
                        if (items.isEmpty) {
                          return Text(
                            l10n.missionsAppearLater,
                            style: text.bodyMedium,
                          );
                        }
                        return ListView(
                          children: [
                            for (var i = 0; i < items.length; i++)
                              CompassAppear(
                                delay: Duration(milliseconds: 80 * i),
                                child: CompassSoftRow(
                                  title: items[i].title,
                                  subtitle: items[i].description,
                                  trailing: items[i].isComplete
                                      ? Icon(
                                          Icons.check_circle_rounded,
                                          color: scheme.primary,
                                          size: 20,
                                        )
                                      : null,
                                ),
                              ),
                          ],
                        );
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                      error: (error, _) => Text('$error'),
                    ),
                  ),
                  CompassPrimaryButton(
                    label: l10n.openDashboard,
                    onPressed: () => context.go(AppRoutes.home),
                  ),
                  const SizedBox(height: CompassSpacing.md),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
