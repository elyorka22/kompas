import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/features/daily_goals/providers/daily_goals_providers.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/presentation/shell/app_shell.dart';

/// Architecture shell for Home. Feature UI arrives in the next milestone.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(activeUserProvider);
    final missions = ref.watch(todaysMissionsProvider);
    final text = Theme.of(context).textTheme;

    return ListView(
      children: [
        ShellHeader(
          title: AppConstants.appName,
          subtitle: user.maybeWhen(
            data: (value) => value == null
                ? 'Conversation coach'
                : 'Hello, ${value.displayName}',
            orElse: () => 'Conversation coach',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CompassSpacing.screenHorizontal,
          ),
          child: CompassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Today', style: text.titleLarge),
                const SizedBox(height: CompassSpacing.xs),
                Text(
                  'Daily missions are generated offline by Compass Engine.',
                  style: text.bodyMedium,
                ),
                const SizedBox(height: CompassSpacing.md),
                missions.when(
                  data: (items) => Text(
                    items.isEmpty
                        ? 'No missions yet'
                        : '${items.length} missions ready',
                    style: text.labelLarge,
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (error, _) => Text('$error'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
