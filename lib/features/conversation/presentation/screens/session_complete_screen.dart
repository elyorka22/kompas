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

    if (finished == null || finished.session.id != sessionId) {
      return Scaffold(
        appBar: CompassAppBar(title: l10n.sessionComplete),
        body: Center(
          child: CompassPrimaryButton(
            label: l10n.backHome,
            onPressed: () => context.go(AppRoutes.home),
          ),
        ),
      );
    }

    final session = finished.session;
    final xp = SkillXpRules.sessionFinishXp +
        (session.currentExerciseId != null
            ? SkillXpRules.primaryExerciseXp
            : 0);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CompassAtmosphere(
        child: SafeArea(
          child: CompassAppear(
            child: ListView(
              padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
              children: [
                const SizedBox(height: CompassSpacing.lg),
                CompassHeroPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: CompassPulse(
                          child: CompassWidget(size: 88),
                        ),
                      ),
                      const SizedBox(height: CompassSpacing.lg),
                      Text(
                        l10n.sessionComplete,
                        style: text.displaySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: CompassSpacing.sm),
                      Text(
                        l10n.sessionRecordedOffline,
                        style: text.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.92),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: CompassSpacing.xl),
                Row(
                  children: [
                    Expanded(
                      child: CompassStatisticCard(
                        label: l10n.speaking,
                        value: '${session.speakingSeconds}s',
                        icon: CompassIcons.practice,
                      ),
                    ),
                    const SizedBox(width: CompassSpacing.sm),
                    Expanded(
                      child: CompassStatisticCard(
                        label: l10n.xpEarned,
                        value: '+$xp',
                        icon: CompassIcons.skills,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: CompassSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: CompassStatisticCard(
                        label: l10n.streak,
                        value: '${finished.streakDays}d',
                        icon: CompassIcons.streak,
                      ),
                    ),
                    const SizedBox(width: CompassSpacing.sm),
                    Expanded(
                      child: CompassStatisticCard(
                        label: l10n.sessions,
                        value: '${finished.statistics.completedSessions}',
                        icon: CompassIcons.progress,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: CompassSpacing.xl),
                CompassSectionHeader(title: l10n.skillGrowth),
                const SizedBox(height: CompassSpacing.md),
              if (finished.updatedSkills.isEmpty)
                CompassCard(child: Text(l10n.noSkillXp))
              else
                for (final skill in finished.updatedSkills) ...[
                  CompassSkillCard(
                    title: DefaultSkillCatalog.byId(skill.skillId)?.title ??
                        skill.skillId,
                    subtitle: '${skill.xp} XP · ${skill.status.name}',
                    progress: () {
                      final catalog = DefaultSkillCatalog.byId(skill.skillId);
                      if (catalog == null || catalog.xpToMaster <= 0) {
                        return 0.0;
                      }
                      return (skill.xp / catalog.xpToMaster).clamp(0.0, 1.0);
                    }(),
                  ),
                  const SizedBox(height: CompassSpacing.sm),
                ],
              const SizedBox(height: CompassSpacing.lg),
              CompassSectionHeader(title: l10n.coachRecommendation),
              const SizedBox(height: CompassSpacing.md),
              CompassCard(
                child: Text(
                  strategy.maybeWhen(
                    data: (value) {
                      if (value == null || value.reasons.isEmpty) {
                        return l10n.keepSteadyRhythm;
                      }
                      return value.reasons.map((r) => r.message).join(' ');
                    },
                    orElse: () => l10n.coachPreparingFocus,
                  ),
                  style: text.bodyLarge,
                ),
              ),
              const SizedBox(height: CompassSpacing.xl),
              CompassSectionHeader(title: l10n.nextSuggestedExercise),
              const SizedBox(height: CompassSpacing.md),
              nextExercise.when(
                data: (exercise) {
                  if (exercise == null) {
                    return CompassCard(
                      child: Text(l10n.openPracticeToContinue),
                    );
                  }
                  return CompassExerciseCard(
                    title: exercise.title,
                    subtitle: exercise.prompt,
                    meta: l10n.practiceModeTitle(exercise.mode.name),
                    onTap: () => context.go(AppRoutes.practice),
                  );
                },
                loading: () => const LinearProgressIndicator(),
                error: (error, _) => Text('$error'),
              ),
              const SizedBox(height: CompassSpacing.xl),
              CompassPrimaryButton(
                label: l10n.backToDashboard,
                onPressed: () => context.go(AppRoutes.home),
              ),
              const SizedBox(height: CompassSpacing.sm),
              CompassSecondaryButton(
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
