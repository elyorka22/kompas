import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/features/compass_engine/domain/usecases/start_session.dart';
import 'package:kompas/features/daily_goals/providers/daily_goals_providers.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/features/progress/providers/progress_providers.dart';
import 'package:kompas/navigation/app_routes.dart';
import 'package:kompas/services/compass/practice_mode_catalog.dart';

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
    final text = Theme.of(context).textTheme;

    final greeting = user.maybeWhen(
      data: (value) => value == null ? 'Welcome' : 'Hello, ${value.displayName}',
      orElse: () => 'Welcome',
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
                Text(AppConstants.appName, style: text.headlineMedium),
                Text(greeting, style: text.bodyMedium),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(CompassIcons.settings),
          ),
        ],
      ),
      hero: CompassAppear(
        child: CompassCard.elevated(
          child: Row(
            children: [
              CompassProgressRing(
                value: ringValue,
                size: 88,
                child: Text(
                  '${(ringValue * 100).round()}%',
                  style: text.labelLarge,
                ),
              ),
              const SizedBox(width: CompassSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today’s progress', style: text.titleLarge),
                    const SizedBox(height: CompassSpacing.xxs),
                    Text(
                      completion.maybeWhen(
                        data: (value) => value == null
                            ? 'Missions load with Compass Engine'
                            : '${value.completedMissions}/${value.totalMissions} missions',
                        orElse: () => 'Loading…',
                      ),
                      style: text.bodyMedium,
                    ),
                    const SizedBox(height: CompassSpacing.sm),
                    CompassBadge(
                      label: streak == 1
                          ? '1 day streak'
                          : '$streak day streak',
                      tone: CompassBadgeTone.brand,
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
            const CompassSectionHeader(
              title: 'Today’s mission',
              subtitle: 'Generated offline by Compass Engine',
            ),
            const SizedBox(height: CompassSpacing.md),
            missions.when(
              data: (items) {
                if (items.isEmpty) {
                  return const CompassCard(
                    child: Text(
                      'No missions yet. Start a practice session to begin.',
                    ),
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
              const CompassSectionHeader(title: 'Continue practice'),
              const SizedBox(height: CompassSpacing.md),
              exercise.when(
                data: (item) {
                  if (item == null) {
                    return CompassCard(
                      child: Text(
                        strategy.maybeWhen(
                          data: (s) => s?.reasons.isNotEmpty == true
                              ? s!.reasons.first.message
                              : 'Coach Engine will recommend your next exercise.',
                          orElse: () =>
                              'Coach Engine will recommend your next exercise.',
                        ),
                      ),
                    );
                  }
                  return CompassExerciseCard(
                    title: item.title,
                    subtitle: item.prompt,
                    meta:
                        '${PracticeModeCatalog.title(item.mode)} · ${item.difficulty.name}',
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
                label: 'Open practice',
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
                title: 'Notebook',
                action: CompassGhostButton(
                  label: 'Open',
                  onPressed: () => context.go(AppRoutes.notebook),
                ),
              ),
              const SizedBox(height: CompassSpacing.sm),
              const CompassCard(
                child: Text(
                  'Save expressions from practice. Memory Engine keeps them for review.',
                ),
              ),
            ],
          ),
        ),
        CompassAppear(
          delay: const Duration(milliseconds: 200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CompassSectionHeader(title: 'Skill progress'),
              const SizedBox(height: CompassSpacing.md),
              skills.when(
                data: (views) {
                  if (views.isEmpty) {
                    return const CompassCard(
                      child: Text(
                        'Skill XP appears after your first finished session.',
                      ),
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
              const CompassSectionHeader(title: 'Recent activity'),
              const SizedBox(height: CompassSpacing.md),
              recent.when(
                data: (sessions) {
                  if (sessions.isEmpty) {
                    return const CompassCard(
                      child: Text(
                        'Finish a session to see your activity timeline.',
                      ),
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
                                      '${PracticeModeCatalog.title(session.mode)} · ${session.speakingSeconds}s',
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
