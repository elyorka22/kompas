import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/features/achievements/providers/achievements_providers.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/features/progress/providers/progress_providers.dart';
import 'package:kompas/features/skill_tree/providers/skill_tree_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/shared/catalog/default_learning_path_catalog.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(userStatisticsProvider);
    final skills = ref.watch(skillProgressViewsProvider);
    final insights = ref.watch(memoryInsightsProvider);
    final recent = ref.watch(recentSessionsProvider);
    final achievements = ref.watch(achievementsProvider);
    final tree = ref.watch(skillTreeProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;

    return CompassProgressTemplate(
      header: CompassSectionHeader(
        title: l10n.progressTitle,
        subtitle: l10n.progressSubtitle,
      ),
      overview: stats.when(
        data: (value) {
          if (value == null) {
            return CompassCard(
              child: Text(l10n.completeSessionForProgress),
            );
          }
          return CompassAppear(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CompassStatisticCard(
                        label: l10n.speaking,
                        value: '${value.totalSpeakingMinutes}m',
                        icon: CompassIcons.practice,
                      ),
                    ),
                    const SizedBox(width: CompassSpacing.sm),
                    Expanded(
                      child: CompassStatisticCard(
                        label: l10n.streak,
                        value: '${value.currentStreakDays}',
                        caption: l10n.bestStreak(value.longestStreakDays),
                        icon: CompassIcons.streak,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: CompassSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: CompassStatisticCard(
                        label: l10n.sessions,
                        value: '${value.completedSessions}',
                        icon: CompassIcons.progress,
                      ),
                    ),
                    const SizedBox(width: CompassSpacing.sm),
                    Expanded(
                      child: CompassStatisticCard(
                        label: 'Memory',
                        value: '${value.expressionsSaved}',
                        caption: '${value.expressionsMastered} mastered',
                        icon: CompassIcons.notebook,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const LinearProgressIndicator(),
        error: (error, _) => Text('$error'),
      ),
      charts: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CompassSectionHeader(title: l10n.weeklyActivity),
          const SizedBox(height: CompassSpacing.md),
          recent.when(
            data: (sessions) {
              if (sessions.isEmpty) {
                return CompassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CompassIllustration(
                        kind: CompassIllustrationKind.constellation,
                        height: 120,
                      ),
                      const SizedBox(height: CompassSpacing.md),
                      Text(
                        l10n.noWeeklyYet,
                        style: text.bodyMedium,
                      ),
                    ],
                  ),
                );
              }
              final totalSeconds = sessions.fold<int>(
                0,
                (sum, item) => sum + item.speakingSeconds,
              );
              return CompassCard(
                child: Column(
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
                    ),
                    const SizedBox(height: CompassSpacing.sm),
                    Text(
                      l10n.towardWeeklyCadence,
                      style: text.bodySmall,
                    ),
                  ],
                ),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
        ],
      ),
      details: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CompassSectionHeader(title: l10n.skills),
          const SizedBox(height: CompassSpacing.md),
          skills.when(
            data: (views) {
              if (views.isEmpty) {
                return CompassCard(
                  child: Text(l10n.skillGrowthStarts),
                );
              }
              return Column(
                children: [
                  for (final view in views) ...[
                    CompassSkillCard(
                      title: view.skill.title,
                      subtitle:
                          '${view.progress.status.name} · ${view.progress.xp}/${view.skill.xpToMaster} XP',
                      progress: view.ratio,
                    ),
                    const SizedBox(height: CompassSpacing.sm),
                  ],
                ],
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
          const SizedBox(height: CompassSpacing.xl),
          CompassSectionHeader(title: l10n.learningPath),
          const SizedBox(height: CompassSpacing.md),
          tree.when(
            data: (_) {
              final path = DefaultLearningPathCatalog.paths.isEmpty
                  ? null
                  : DefaultLearningPathCatalog.paths.first;
              if (path == null) {
                return CompassCard(child: Text(l10n.pathUnavailable));
              }
              return CompassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(path.title, style: text.titleLarge),
                    const SizedBox(height: CompassSpacing.xs),
                    Text(path.description, style: text.bodyMedium),
                    const SizedBox(height: CompassSpacing.md),
                    Text(
                      l10n.skillsOnPath(path.skillIds.length),
                      style: text.labelMedium,
                    ),
                  ],
                ),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
          const SizedBox(height: CompassSpacing.xl),
          CompassSectionHeader(title: l10n.achievements),
          const SizedBox(height: CompassSpacing.md),
          achievements.when(
            data: (snapshot) {
              if (snapshot == null || snapshot.catalog.isEmpty) {
                return CompassCard(
                  child: Text(l10n.achievementsEmpty),
                );
              }
              final unlockedIds = {
                for (final item in snapshot.userAchievements) item.achievementId,
              };
              return Column(
                children: [
                  for (final item in snapshot.catalog.take(5)) ...[
                    CompassCard(
                      padding: const EdgeInsets.all(CompassSpacing.md),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(item.title, style: text.titleMedium),
                          ),
                          CompassBadge(
                            label: unlockedIds.contains(item.id)
                                ? l10n.unlocked
                                : l10n.locked,
                            tone: unlockedIds.contains(item.id)
                                ? CompassBadgeTone.success
                                : CompassBadgeTone.neutral,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: CompassSpacing.sm),
                  ],
                ],
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
          const SizedBox(height: CompassSpacing.xl),
          CompassSectionHeader(title: l10n.memoryInsights),
          const SizedBox(height: CompassSpacing.md),
          insights.when(
            data: (lines) {
              return CompassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in lines) ...[
                      Text('• $line', style: text.bodyMedium),
                      const SizedBox(height: CompassSpacing.xs),
                    ],
                  ],
                ),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
        ],
      ),
    );
  }
}
