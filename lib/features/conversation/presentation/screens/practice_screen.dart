import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/features/compass_engine/domain/usecases/start_session.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/navigation/app_routes.dart';

/// Simple missions / practice list.
class PracticeScreen extends ConsumerWidget {
  const PracticeScreen({super.key});

  static const _modes = <PracticeMode>[
    PracticeMode.tellAboutDay,
    PracticeMode.describeImage,
    PracticeMode.defendOpinion,
    PracticeMode.continueStory,
  ];

  Future<void> _start(
    BuildContext context,
    WidgetRef ref, {
    required PracticeMode mode,
  }) async {
    final user = await ref.read(activeUserProvider.future);
    if (user == null || !context.mounted) return;
    final result = await ref.read(startSessionProvider)(
      StartSessionParams(userId: user.id, mode: mode),
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
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
          children: [
            Text(l10n.practiceTitle, style: text.headlineSmall),
            const SizedBox(height: CompassSpacing.xs),
            Text(
              l10n.practiceSubtitle,
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: CompassSpacing.xl),
            for (final mode in _modes) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.practiceModeTitle(mode.name)),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => _start(context, ref, mode: mode),
              ),
              Divider(color: scheme.outlineVariant.withOpacity(0.5)),
            ],
          ],
        ),
      ),
    );
  }
}
