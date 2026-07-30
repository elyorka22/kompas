import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/features/progress/providers/progress_providers.dart';
import 'package:kompas/presentation/shell/app_shell.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(userStatisticsProvider);
    final text = Theme.of(context).textTheme;

    return ListView(
      children: [
        const ShellHeader(
          title: 'Progress',
          subtitle: 'Quiet metrics. No streak guilt.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CompassSpacing.screenHorizontal,
          ),
          child: stats.when(
            data: (value) {
              if (value == null) {
                return CompassCard(
                  child: Text(
                    'Statistics appear after your first practice.',
                    style: text.bodyMedium,
                  ),
                );
              }
              return CompassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${value.totalSpeakingMinutes} min spoken',
                      style: text.headlineSmall,
                    ),
                    const SizedBox(height: CompassSpacing.sm),
                    Text(
                      '${value.completedSessions} sessions · ${value.expressionsSaved} expressions · streak ${value.currentStreakDays}',
                      style: text.bodyMedium,
                    ),
                  ],
                ),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
        ),
      ],
    );
  }
}
