import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/features/achievements/providers/achievements_providers.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/features/progress/providers/progress_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(userStatisticsProvider);
    final skills = ref.watch(skillProgressViewsProvider);
    final insights = ref.watch(memoryInsightsProvider);
    final recent = ref.watch(recentSessionsProvider);
    final achievements = ref.watch(achievementsProvider);
    final strategy = ref.watch(learningStrategyProvider);
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

    final topSkill = skills.maybeWhen(
      data: (views) => views.isEmpty ? null : views.first,
      orElse: () => null,
    );

    final streak = stats.maybeWhen(
      data: (value) => value?.currentStreakDays ?? 0,
      orElse: () => 0,
    );

    final nextFocus = strategy.maybeWhen(
      data: (value) {
        if (value == null || value.prioritySkillIds.isEmpty) return null;
        return skillTitle(value.prioritySkillIds.first);
      },
      orElse: () => null,
    );

    return CompassPageTemplate(
      header: CompassPageIntro(
        title: l10n.progressTitle,
        subtitle: l10n.progressSubtitle,
      ),
      children: [
        CompassAppear(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.yourStory,
                style: text.labelLarge?.copyWith(color: scheme.primary),
              ),
              const SizedBox(height: CompassSpacing.lg),
              CompassInsightStory(
                story: l10n.spokeThisWeek(weekMinutes),
                emphasis: true,
              ),
              if (topSkill != null)
                CompassInsightStory(
                  story: l10n.improvedSkill(
                    topSkill.skill.title,
                    (topSkill.ratio * 100).round().clamp(1, 100),
                  ),
                ),
              CompassInsightStory(story: l10n.streakStory(streak)),
              if (nextFocus != null)
                CompassInsightStory(story: l10n.coachNextFocus(nextFocus)),
              insights.when(
                data: (lines) {
                  return Column(
                    children: [
                      for (final line in lines.take(3))
                        CompassInsightStory(story: line),
                    ],
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
        CompassQuietSection(
          label: l10n.weeklyActivity,
          child: recent.when(
            data: (sessions) {
              if (sessions.isEmpty) {
                return Text(l10n.noWeeklyYet, style: text.bodyMedium);
              }
              final totalSeconds = sessions.fold<int>(
                0,
                (sum, item) => sum + item.speakingSeconds,
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.recentSessionsSummary(
                      sessions.length,
                      totalSeconds ~/ 60,
                    ),
                    style: text.titleMedium,
                  ),
                  const SizedBox(height: CompassSpacing.md),
                  CompassProgressBar(
                    value: (totalSeconds / (7 * 600)).clamp(0.0, 1.0),
                    height: 6,
                  ),
                  const SizedBox(height: CompassSpacing.sm),
                  Text(
                    l10n.towardWeeklyCadence,
                    style: text.bodySmall,
                  ),
                ],
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
        ),
        CompassQuietSection(
          label: l10n.skills,
          child: skills.when(
            data: (views) {
              if (views.isEmpty) {
                return Text(l10n.skillGrowthStarts, style: text.bodyMedium);
              }
              return Column(
                children: [
                  for (final view in views.take(4)) ...[
                    CompassSoftRow(
                      title: view.skill.title,
                      subtitle:
                          '${view.progress.xp}/${view.skill.xpToMaster} XP',
                      trailing: SizedBox(
                        width: 88,
                        child: CompassProgressBar(value: view.ratio, height: 4),
                      ),
                    ),
                  ],
                ],
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
        ),
        CompassQuietSection(
          label: l10n.achievements,
          child: achievements.when(
            data: (snapshot) {
              if (snapshot == null || snapshot.catalog.isEmpty) {
                return Text(l10n.achievementsEmpty, style: text.bodyMedium);
              }
              final unlockedIds = {
                for (final item in snapshot.userAchievements)
                  item.achievementId,
              };
              final unlocked = snapshot.catalog
                  .where((item) => unlockedIds.contains(item.id))
                  .take(4)
                  .toList();
              if (unlocked.isEmpty) {
                return Text(l10n.achievementsEmpty, style: text.bodyMedium);
              }
              return Column(
                children: [
                  for (final item in unlocked)
                    CompassSoftRow(
                      title: item.title,
                      trailing: Icon(
                        Icons.check_circle_rounded,
                        color: scheme.primary,
                        size: 18,
                      ),
                    ),
                ],
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
