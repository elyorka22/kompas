import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/features/progress/providers/progress_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';

/// Simple progress: streak + weekly speaking time.
class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(userStatisticsProvider);
    final recent = ref.watch(recentSessionsProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final weekMinutes = recent.maybeWhen(
      data: (sessions) => sessions.fold<int>(
            0,
            (sum, item) => sum + item.speakingSeconds,
          ) ~/
          60,
      orElse: () => 0,
    );

    final streak = stats.maybeWhen(
      data: (value) => value?.currentStreakDays ?? 0,
      orElse: () => 0,
    );

    final sessionCount = recent.maybeWhen(
      data: (sessions) => sessions.length,
      orElse: () => 0,
    );

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
          children: [
            Text(l10n.progressTitle, style: text.headlineSmall),
            const SizedBox(height: CompassSpacing.xs),
            Text(
              l10n.progressSubtitle,
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: CompassSpacing.xl),
            _StatCard(
              title: l10n.streakStory(streak),
              subtitle: l10n.spokeThisWeek(weekMinutes),
            ),
            const SizedBox(height: CompassSpacing.md),
            _StatCard(
              title: l10n.recentSessionsSummary(sessionCount, weekMinutes),
              subtitle: l10n.towardWeeklyCadence,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(CompassSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withOpacity(0.45),
        borderRadius: BorderRadius.circular(CompassRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: text.titleMedium),
          const SizedBox(height: CompassSpacing.sm),
          Text(
            subtitle,
            style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
