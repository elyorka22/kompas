import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/features/compass_engine/domain/usecases/start_session.dart';
import 'package:kompas/features/daily_goals/providers/daily_goals_providers.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/features/progress/providers/progress_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/navigation/app_routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _startPractice(
    BuildContext context,
    WidgetRef ref, {
    PracticeMode? mode,
    String? exerciseId,
  }) async {
    final user = await ref.read(activeUserProvider.future);
    if (user == null || !context.mounted) return;

    final result = await ref.read(startSessionProvider)(
      StartSessionParams(
        userId: user.id,
        mode: mode,
        exerciseId: exerciseId,
      ),
    );
    if (!context.mounted) return;
    result.fold(
      onSuccess: (session) {
        context.push(AppRoutes.sessionPath(session.id));
      },
      onFailure: (failure) {
        CompassSnackbars.show(context, message: failure.message);
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(activeUserProvider);
    final missions = ref.watch(todaysMissionsProvider);
    final completion = ref.watch(dailyCompletionProvider);
    final stats = ref.watch(userStatisticsProvider);
    final exercise = ref.watch(recommendedExerciseProvider);
    final strategy = ref.watch(learningStrategyProvider);
    final skills = ref.watch(skillProgressViewsProvider);
    final recent = ref.watch(recentSessionsProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;

    final greeting = user.maybeWhen(
      data: (value) =>
          value == null ? l10n.welcome : l10n.helloName(value.displayName),
      orElse: () => l10n.welcome,
    );

    final ringValue = completion.maybeWhen(
      data: (value) => value?.ratio ?? 0,
      orElse: () => 0.0,
    );

    final streak = stats.maybeWhen(
      data: (value) => value?.currentStreakDays ?? 0,
      orElse: () => 0,
    );

    return CompassDashboardTemplate(
      header: Row(
        children: [
          const CompassMark(size: 32),
          const SizedBox(width: CompassSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.appName, style: text.headlineMedium),
                Text(greeting, style: text.bodyMedium),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n.settings,
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(CompassIcons.settings),
          ),
        ],
      ),
      hero: CompassAppear(
        child: CompassHeroPanel(
          child: Row(
            children: [
              CompassProgressRing(
                value: ringValue,
                size: 88,
                onDark: true,
                child: Text(
                  '${(ringValue * 100).round()}%',
                  style: text.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: CompassSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.todaysProgress,
                      style: text.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: CompassSpacing.xxs),
                    Text(
                      completion.maybeWhen(
                        data: (value) => value == null
                            ? l10n.missionsLoading
                            : l10n.missionsCount(
                                value.completedMissions,
                                value.totalMissions,
                              ),
                        orElse: () => l10n.loading,
                      ),
                      style: text.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: CompassSpacing.sm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: CompassSpacing.sm,
                        vertical: CompassSpacing.xxs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(CompassRadii.sm),
                      ),
                      child: Text(
                        l10n.streakDays(streak),
                        style: text.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      missions: CompassAppear(
        delay: const Duration(milliseconds: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompassSectionHeader(
              title: l10n.todaysMission,
              subtitle: l10n.todaysMissionSubtitle,
            ),
            const SizedBox(height: CompassSpacing.md),
            missions.when(
              data: (items) {
                if (items.isEmpty) {
                  return CompassCard(
                    child: Text(l10n.noMissionsYet),
                  );
                }
                return Column(
                  children: [
                    for (var i = 0; i < items.length; i++) ...[
                      _MissionTile(
                        mission: items[i],
                        onStart: () => _startPractice(context, ref),
                      ),
                      if (i != items.length - 1)
                        const SizedBox(height: CompassSpacing.sm),
                    ],
                  ],
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (error, _) => Text('$error'),
            ),
          ],
        ),
      ),
      secondary: [
        CompassAppear(
          delay: const Duration(milliseconds: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompassSectionHeader(title: l10n.continuePractice),
              const SizedBox(height: CompassSpacing.md),
              exercise.when(
                data: (item) {
                  if (item == null) {
                    return CompassCard(
                      child: Text(
                        strategy.maybeWhen(
                          data: (s) => s?.reasons.isNotEmpty == true
                              ? s!.reasons.first.message
                              : l10n.coachWillRecommend,
                          orElse: () => l10n.coachWillRecommend,
                        ),
                      ),
                    );
                  }
                  return CompassExerciseCard(
                    title: item.title,
                    subtitle: item.prompt,
                    meta:
                        '${l10n.practiceModeTitle(item.mode.name)} · ${item.difficulty.name}',
                    onTap: () => _startPractice(
                      context,
                      ref,
                      mode: item.mode,
                      exerciseId: item.id,
                    ),
                    trailing: const Icon(CompassIcons.chevronRight),
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (error, _) => Text('$error'),
              ),
              const SizedBox(height: CompassSpacing.sm),
              CompassSecondaryButton(
                label: l10n.openPractice,
                onPressed: () => context.go(AppRoutes.practice),
              ),
            ],
          ),
        ),
        CompassAppear(
          delay: const Duration(milliseconds: 160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompassSectionHeader(
                title: l10n.notebook,
                action: CompassGhostButton(
                  label: l10n.open,
                  onPressed: () => context.go(AppRoutes.notebook),
                ),
              ),
              const SizedBox(height: CompassSpacing.sm),
              CompassCard(
                child: Text(l10n.notebookHomeHint),
              ),
            ],
          ),
        ),
        CompassAppear(
          delay: const Duration(milliseconds: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompassSectionHeader(title: l10n.skillProgress),
              const SizedBox(height: CompassSpacing.md),
              skills.when(
                data: (views) {
                  if (views.isEmpty) {
                    return CompassCard(
                      child: Text(l10n.skillXpAfterSession),
                    );
                  }
                  return Column(
                    children: [
                      for (final view in views.take(3)) ...[
                        CompassSkillCard(
                          title: view.skill.title,
                          subtitle: '${view.progress.xp} XP',
                          progress: view.ratio,
                          onTap: () => context.go(AppRoutes.skills),
                        ),
                        const SizedBox(height: CompassSpacing.sm),
                      ],
                    ],
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (error, _) => Text('$error'),
              ),
            ],
          ),
        ),
        CompassAppear(
          delay: const Duration(milliseconds: 240),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CompassSectionHeader(title: l10n.recentActivity),
              const SizedBox(height: CompassSpacing.md),
              recent.when(
                data: (sessions) {
                  if (sessions.isEmpty) {
                    return CompassCard(
                      child: Text(l10n.finishSessionForActivity),
                    );
                  }
                  return Column(
                    children: [
                      for (final session in sessions) ...[
                        CompassCard(
                          padding: const EdgeInsets.all(CompassSpacing.md),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(session.title, style: text.titleSmall),
                                    Text(
                                      '${l10n.practiceModeTitle(session.mode.name)} · ${session.speakingSeconds}s',
                                      style: text.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              CompassBadge(
                                label: '+${session.speakingSeconds ~/ 60}m',
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
            ],
          ),
        ),
      ],
    );
  }
}

class _MissionTile extends StatelessWidget {
  const _MissionTile({required this.mission, required this.onStart});

  final DailyMission mission;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return CompassMissionCard(
      title: mission.title,
      subtitle: mission.description,
      progress: mission.progressRatio,
      completed: mission.isComplete,
      onTap: mission.isComplete ? null : onStart,
    );
  }
}
