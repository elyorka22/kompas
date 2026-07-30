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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommended = ref.watch(recommendedExerciseProvider);
    final strategy = ref.watch(learningStrategyProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;

    return CompassPageTemplate(
      header: CompassSectionHeader(
        title: l10n.practiceTitle,
        subtitle: l10n.practiceSubtitle,
      ),
      children: [
        CompassAppear(
          child: recommended.when(
            data: (exercise) {
              if (exercise == null) {
                return CompassCard(
                  child: Text(l10n.noExerciseYet),
                );
              }
              final reason = strategy.maybeWhen(
                data: (value) => value?.reasons.isNotEmpty == true
                    ? value!.reasons.first.message
                    : l10n.recommendedByCoach,
                orElse: () => l10n.recommendedByCoach,
              );
              return CompassExerciseCard(
                title: exercise.title,
                subtitle: exercise.prompt,
                meta: reason,
                onTap: () => _start(
                  context,
                  ref,
                  mode: exercise.mode,
                  exerciseId: exercise.id,
                ),
                trailing: CompassPrimaryButton(
                  label: l10n.start,
                  expanded: false,
                  size: CompassButtonSize.compact,
                  onPressed: () => _start(
                    context,
                    ref,
                    mode: exercise.mode,
                    exerciseId: exercise.id,
                  ),
                ),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.practiceModes, style: text.titleLarge),
            const SizedBox(height: CompassSpacing.md),
            for (final mode in PracticeMode.values) ...[
              CompassAppear(
                delay: Duration(milliseconds: 40 * mode.index),
                child: CompassCard(
                  onTap: () => _start(context, ref, mode: mode),
                  padding: const EdgeInsets.all(CompassSpacing.md),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.practiceModeTitle(mode.name),
                              style: text.titleMedium,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              PracticeModeCatalog.defaultPrompt(mode),
                              style: text.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Icon(CompassIcons.chevronRight),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: CompassSpacing.sm),
            ],
          ],
        ),
      ],
    );
  }
}
