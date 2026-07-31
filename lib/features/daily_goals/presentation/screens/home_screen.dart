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

  String _greeting(KompasL10n l10n, String name) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorningName(name);
    if (hour < 18) return l10n.goodAfternoonName(name);
    return l10n.goodEveningName(name);
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
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final name = user.maybeWhen(
      data: (value) => value?.displayName ?? '',
      orElse: () => '',
    );
    final greeting = name.isEmpty ? l10n.welcome : _greeting(l10n, name);

    final ringValue = completion.maybeWhen(
      data: (value) => value?.ratio ?? 0,
      orElse: () => 0.0,
    );

    final streak = stats.maybeWhen(
      data: (value) => value?.currentStreakDays ?? 0,
      orElse: () => 0,
    );

    final reason = strategy.maybeWhen(
      data: (value) => value?.reasons.isNotEmpty == true
          ? value!.reasons.first.message
          : l10n.coachWillRecommend,
      orElse: () => l10n.coachWillRecommend,
    );

    return CompassPageTemplate(
      header: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CompassAppear(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CompassWidget(size: 36),
                  const SizedBox(height: CompassSpacing.lg),
                  Text(greeting, style: text.displaySmall),
                ],
              ),
            ),
          ),
          IconButton(
            tooltip: l10n.settings,
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(CompassIcons.settings),
          ),
        ],
      ),
      children: [
        CompassAppear(
          delay: const Duration(milliseconds: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.coachRecommendsToday,
                style: text.labelLarge?.copyWith(color: scheme.primary),
              ),
              const SizedBox(height: CompassSpacing.md),
              exercise.when(
                data: (item) {
                  if (item == null) {
                    return CompassQuietSurface(
                      child: Text(l10n.coachWillRecommend, style: text.bodyLarge),
                    );
                  }
                  return CompassCoachRecommend(
                    meta: l10n.recommendedByCoach,
                    title: item.title,
                    reason: '${l10n.reasonLabel}: $reason',
                    actionLabel: l10n.startTodaysSession,
                    onAction: () => _startPractice(
                      context,
                      ref,
                      mode: item.mode,
                      exerciseId: item.id,
                    ),
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (error, _) => Text('$error'),
              ),
            ],
          ),
        ),
        CompassQuietSection(
          label: l10n.todaysMission,
          child: missions.when(
            data: (items) {
              if (items.isEmpty) {
                return Text(l10n.noMissionsYet, style: text.bodyMedium);
              }
              return Column(
                children: [
                  for (final mission in items.take(3))
                    _MissionSoftRow(
                      mission: mission,
                      onStart: () => _startPractice(context, ref),
                    ),
                ],
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
        ),
        CompassQuietSection(
          label: l10n.todaysProgress,
          child: CompassAppear(
            delay: const Duration(milliseconds: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${(ringValue * 100).round()}%',
                      style: text.headlineMedium,
                    ),
                    const SizedBox(width: CompassSpacing.md),
                    Expanded(
                      child: Text(
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
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: CompassSpacing.md),
                CompassProgressBar(value: ringValue, height: 6),
                if (streak > 0) ...[
                  const SizedBox(height: CompassSpacing.md),
                  Text(
                    l10n.streakDays(streak),
                    style: text.labelMedium?.copyWith(color: scheme.primary),
                  ),
                ],
              ],
            ),
          ),
        ),
        CompassQuietSection(
          label: l10n.recentAchievements,
          child: skills.when(
            data: (views) {
              final growing = views
                  .where((v) => v.progress.xp > 0)
                  .take(2)
                  .toList();
              if (growing.isEmpty) {
                return Text(l10n.skillXpAfterSession, style: text.bodyMedium);
              }
              return Column(
                children: [
                  for (final view in growing)
                    CompassSoftRow(
                      title: view.skill.title,
                      subtitle: '${view.progress.xp} XP',
                      trailing: SizedBox(
                        width: 72,
                        child: CompassProgressBar(value: view.ratio, height: 4),
                      ),
                      onTap: () => context.go(AppRoutes.skills),
                    ),
                ],
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
        ),
        CompassQuietSection(
          label: l10n.notebook,
          child: CompassSoftRow(
            title: l10n.openNotebook,
            subtitle: l10n.notebookHomeHint,
            leading: Icon(CompassIcons.notebook, color: scheme.primary),
            onTap: () => context.go(AppRoutes.notebook),
          ),
        ),
      ],
    );
  }
}

class _MissionSoftRow extends StatelessWidget {
  const _MissionSoftRow({required this.mission, required this.onStart});

  final DailyMission mission;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return CompassSoftRow(
      title: mission.title,
      subtitle: mission.description,
      trailing: mission.isComplete
          ? Icon(
              Icons.check_circle_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            )
          : null,
      onTap: mission.isComplete ? null : onStart,
    );
  }
}
