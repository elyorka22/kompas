import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/features/conversation/providers/session_providers.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/navigation/app_routes.dart';
import 'package:kompas/services/compass/skill_xp_rules.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

class SessionCompleteScreen extends ConsumerWidget {
  const SessionCompleteScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finished = ref.watch(lastFinishedSessionProvider);
    final nextExercise = ref.watch(recommendedExerciseProvider);
    final strategy = ref.watch(learningStrategyProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    if (finished == null || finished.session.id != sessionId) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: CompassAtmosphere(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(CompassSpacing.lg),
              child: CompassPrimaryButton(
                label: l10n.backHome,
                onPressed: () => context.go(AppRoutes.coach),
              ),
            ),
          ),
        ),
      );
    }

    final session = finished.session;
    final xp = SkillXpRules.sessionFinishXp +
        (session.currentExerciseId != null
            ? SkillXpRules.primaryExerciseXp
            : 0);
    final minutes = session.speakingSeconds ~/ 60;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CompassAtmosphere(
        child: SafeArea(
          child: CompassAppear(
            child: ListView(
              padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
              children: [
                const SizedBox(height: CompassSpacing.xl),
                const Center(
                  child: CompassPulse(child: CompassWidget(size: 72)),
                ),
                const SizedBox(height: CompassSpacing.xl),
                Text(l10n.sessionComplete, style: text.displaySmall),
                const SizedBox(height: CompassSpacing.md),
                CompassInsightStory(
                  story: l10n.spokeThisWeek(
                    minutes > 0 ? minutes : 1,
                  ),
                  emphasis: true,
                ),
                CompassInsightStory(
                  story: '+$xp XP · ${l10n.streakDays(finished.streakDays)}',
                ),
                const SizedBox(height: CompassSpacing.lg),
                Text(
                  l10n.skillGrowth,
                  style: text.labelLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: CompassSpacing.md),
                if (finished.updatedSkills.isEmpty)
                  Text(l10n.noSkillXp, style: text.bodyMedium)
                else
                  for (final skill in finished.updatedSkills) ...[
                    CompassSoftRow(
                      title: DefaultSkillCatalog.byId(skill.skillId)?.title ??
                          skill.skillId,
                      subtitle: '${skill.xp} XP · ${skill.status.name}',
                      trailing: SizedBox(
                        width: 72,
                        child: CompassProgressBar(
                          value: skill.progressRatio(
                            xpToMaster: DefaultSkillCatalog.byId(skill.skillId)
                                    ?.xpToMaster ??
                                100,
                          ),
                          height: 4,
                        ),
                      ),
                    ),
                  ],
                const SizedBox(height: CompassSpacing.xl),
                Text(
                  l10n.coachRecommendation,
                  style: text.labelLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: CompassSpacing.md),
                Text(
                  strategy.maybeWhen(
                    data: (value) {
                      if (value == null || value.reasons.isEmpty) {
                        return l10n.keepSteadyRhythm;
                      }
                      return value.reasons.map((r) => r.message).join(' ');
                    },
                    orElse: () => l10n.coachPreparingFocus,
                  ),
                  style: text.titleLarge?.copyWith(height: 1.4),
                ),
                const SizedBox(height: CompassSpacing.xl),
                nextExercise.when(
                  data: (exercise) {
                    if (exercise == null) {
                      return const SizedBox.shrink();
                    }
                    return CompassCoachRecommend(
                      meta: l10n.nextSuggestedExercise,
                      title: exercise.title,
                      reason: exercise.prompt,
                      actionLabel: l10n.openPractice,
                      onAction: () => context.go(AppRoutes.practice),
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                const SizedBox(height: CompassSpacing.xl),
                CompassPrimaryButton(
                  label: l10n.backToDashboard,
                  onPressed: () => context.go(AppRoutes.coach),
                ),
                const SizedBox(height: CompassSpacing.sm),
                CompassGhostButton(
                  label: l10n.viewProgress,
                  onPressed: () => context.go(AppRoutes.progress),
                ),
                const SizedBox(height: CompassSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
