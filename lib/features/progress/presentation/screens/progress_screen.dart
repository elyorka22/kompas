import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/features/achievements/providers/achievements_providers.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/features/progress/providers/progress_providers.dart';
import 'package:kompas/features/skill_tree/providers/skill_tree_providers.dart';
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
    final text = Theme.of(context).textTheme;

    return CompassProgressTemplate(
      header: const CompassSectionHeader(
        title: 'Progress',
        subtitle: 'Real activity from Compass, Coach, and Memory engines',
      ),
      overview: stats.when(
        data: (value) {
          if (value == null) {
            return const CompassCard(
              child: Text('Complete a session to unlock progress.'),
            );
          }
          return CompassAppear(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CompassStatisticCard(
                        label: 'Speaking',
                        value: '${value.totalSpeakingMinutes}m',
                        icon: CompassIcons.practice,
                      ),
                    ),
                    const SizedBox(width: CompassSpacing.sm),
                    Expanded(
                      child: CompassStatisticCard(
                        label: 'Streak',
                        value: '${value.currentStreakDays}',
                        caption: 'Best ${value.longestStreakDays}',
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
                        label: 'Sessions',
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
          const CompassSectionHeader(title: 'Weekly activity'),
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
                        'No completed sessions yet. Your weekly rhythm will appear here.',
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
                      '${sessions.length} recent sessions · ${totalSeconds ~/ 60} minutes',
                      style: text.titleMedium,
                    ),
                    const SizedBox(height: CompassSpacing.md),
                    CompassProgressBar(
                      value: (totalSeconds / (7 * 600)).clamp(0.0, 1.0),
                    ),
                    const SizedBox(height: CompassSpacing.sm),
                    Text(
                      'Toward a steady weekly speaking cadence',
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
          const CompassSectionHeader(title: 'Skills'),
          const SizedBox(height: CompassSpacing.md),
          skills.when(
            data: (views) {
              if (views.isEmpty) {
                return const CompassCard(
                  child: Text('Skill growth starts after your first session.'),
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
          const CompassSectionHeader(title: 'Learning path'),
          const SizedBox(height: CompassSpacing.md),
          tree.when(
            data: (_) {
              final path = DefaultLearningPathCatalog.paths.isEmpty
                  ? null
                  : DefaultLearningPathCatalog.paths.first;
              if (path == null) {
                return const CompassCard(child: Text('Path unavailable'));
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
                      '${path.skillIds.length} skills on this path',
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
          const CompassSectionHeader(title: 'Achievements'),
          const SizedBox(height: CompassSpacing.md),
          achievements.when(
            data: (snapshot) {
              if (snapshot == null || snapshot.catalog.isEmpty) {
                return const CompassCard(
                  child: Text(
                    'Achievements unlock as you practice — none yet.',
                  ),
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
                                ? 'Unlocked'
                                : 'Locked',
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
          const CompassSectionHeader(title: 'Memory insights'),
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
