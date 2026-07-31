import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/features/compass_engine/domain/usecases/start_session.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/navigation/app_routes.dart';
import 'package:kompas/services/compass/practice_mode_catalog.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

class PracticeScreen extends ConsumerWidget {
  const PracticeScreen({super.key});

  Future<void> _start(
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
      onSuccess: (session) => context.push(AppRoutes.sessionPath(session.id)),
      onFailure: (failure) =>
          CompassSnackbars.show(context, message: failure.message),
    );
  }

  String _skillTitle(String skillId) {
    for (final skill in DefaultSkillCatalog.skills) {
      if (skill.id == skillId) return skill.title;
    }
    return skillId;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommended = ref.watch(recommendedExerciseProvider);
    final strategy = ref.watch(learningStrategyProvider);
    final l10n = KompasL10n.of(context);

    final reason = strategy.maybeWhen(
      data: (value) => value?.reasons.isNotEmpty == true
          ? value!.reasons.first.message
          : l10n.recommendedByCoach,
      orElse: () => l10n.recommendedByCoach,
    );

    final durationLabel = strategy.maybeWhen(
      data: (value) {
        if (value == null) return l10n.estimatedMinutes;
        final minutes = (value.suggestedSpeakingSeconds / 60).ceil().clamp(1, 30);
        return l10n.minutesLabel(minutes);
      },
      orElse: () => l10n.estimatedMinutes,
    );

    return CompassPageTemplate(
      header: CompassPageIntro(
        title: l10n.practiceTitle,
        subtitle: l10n.practiceSubtitle,
      ),
      children: [
        recommended.when(
          data: (exercise) {
            if (exercise == null) {
              return CompassQuietSurface(
                child: Text(l10n.noExerciseYet),
              );
            }
            return CompassMissionExercise(
              featured: true,
              title: exercise.title,
              difficulty: l10n.difficultyLabel(exercise.difficulty.name),
              durationLabel: durationLabel,
              skillsLabel: l10n.skillsTrained(_skillTitle(exercise.primarySkillId)),
              reason: exercise.coachHint?.isNotEmpty == true
                  ? exercise.coachHint!
                  : reason,
              actionLabel: l10n.startMission,
              onAction: () => _start(
                context,
                ref,
                mode: exercise.mode,
                exerciseId: exercise.id,
              ),
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (error, _) => Text('$error'),
        ),
        CompassQuietSection(
          label: l10n.practiceModes,
          child: Column(
            children: [
              for (final mode in PracticeMode.values) ...[
                CompassAppear(
                  delay: Duration(milliseconds: 40 * mode.index),
                  child: CompassMissionExercise(
                    title: l10n.practiceModeTitle(mode.name),
                    difficulty: l10n.difficultyLabel('core'),
                    durationLabel: l10n.estimatedMinutes,
                    skillsLabel: l10n.practiceTitle,
                    reason: PracticeModeCatalog.defaultPrompt(mode),
                    actionLabel: l10n.start,
                    onAction: () => _start(context, ref, mode: mode),
                  ),
                ),
                const SizedBox(height: CompassSpacing.md),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
