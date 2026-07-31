import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/enums/skill_enums.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/features/skill_tree/providers/skill_tree_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';

class SkillTreeScreen extends ConsumerWidget {
  const SkillTreeScreen({super.key});

  CompassSkillNodeState _state(SkillStatus status, bool isFuture) {
    if (isFuture || status == SkillStatus.locked) {
      return CompassSkillNodeState.locked;
    }
    return switch (status) {
      SkillStatus.mastered => CompassSkillNodeState.mastered,
      SkillStatus.inProgress => CompassSkillNodeState.growing,
      SkillStatus.available => CompassSkillNodeState.available,
      SkillStatus.locked => CompassSkillNodeState.locked,
    };
  }

  String _statusLabel(KompasL10n l10n, CompassSkillNodeState state) {
    return switch (state) {
      CompassSkillNodeState.locked => l10n.skillStatusLocked,
      CompassSkillNodeState.available => l10n.skillStatusAvailable,
      CompassSkillNodeState.growing => l10n.skillStatusGrowing,
      CompassSkillNodeState.mastered => l10n.skillStatusMastered,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tree = ref.watch(skillTreeProvider);
    final views = ref.watch(skillProgressViewsProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;

    return CompassPageTemplate(
      header: CompassPageIntro(
        title: l10n.skillTreeTitle,
        subtitle: l10n.skillTreeSubtitle,
        trailing: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: CompassWidget(size: 40),
        ),
      ),
      children: [
        tree.when(
          data: (snapshot) {
            if (snapshot == null) {
              return Text(
                l10n.completeOnboardingForPath,
                style: text.bodyLarge,
              );
            }

            final progressById = {
              for (final item in snapshot.progress) item.skillId: item,
            };
            final viewXp = {
              for (final view in views.maybeWhen(
                data: (list) => list,
                orElse: () => const <SkillProgressView>[],
              ))
                view.skill.id: view,
            };

            final ordered = [...snapshot.skills]
              ..sort((a, b) => a.order.compareTo(b.order));

            return CompassAppear(
              child: Column(
                children: [
                  for (var i = 0; i < ordered.length; i++) ...[
                    Builder(
                      builder: (context) {
                        final skill = ordered[i];
                        final progress = progressById[skill.id];
                        final view = viewXp[skill.id];
                        final status = progress?.status ??
                            (skill.isFuture
                                ? SkillStatus.locked
                                : SkillStatus.available);
                        final state = _state(status, skill.isFuture);
                        final ratio = view?.ratio ??
                            progress?.progressRatio(
                              xpToMaster: skill.xpToMaster,
                            ) ??
                            0.0;
                        final xp = progress?.xp ?? 0;

                        return CompassSkillNode(
                          title: skill.title,
                          subtitle: state == CompassSkillNodeState.locked
                              ? skill.description
                              : l10n.skillXpLabel(xp, skill.xpToMaster),
                          progress: ratio,
                          statusLabel: _statusLabel(l10n, state),
                          state: state,
                          showConnector: i != ordered.length - 1,
                        );
                      },
                    ),
                  ],
                ],
              ),
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (error, _) => Text('$error'),
        ),
      ],
    );
  }
}
