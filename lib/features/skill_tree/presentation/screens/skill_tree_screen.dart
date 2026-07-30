import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/features/skill_tree/providers/skill_tree_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/presentation/shell/app_shell.dart';

class SkillTreeScreen extends ConsumerWidget {
  const SkillTreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tree = ref.watch(skillTreeProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;

    return ListView(
      children: [
        ShellHeader(
          title: l10n.skillTreeTitle,
          subtitle: l10n.skillTreeSubtitle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CompassSpacing.screenHorizontal,
          ),
          child: tree.when(
            data: (snapshot) {
              if (snapshot == null) {
                return CompassCard(
                  child: Text(
                    l10n.completeOnboardingForPath,
                    style: text.bodyMedium,
                  ),
                );
              }
              return Column(
                children: snapshot.skills
                    .map(
                      (skill) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: CompassSpacing.sm),
                        child: CompassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(skill.title, style: text.titleMedium),
                              const SizedBox(height: CompassSpacing.xs),
                              Text(skill.description, style: text.bodyMedium),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text('$error'),
          ),
        ),
      ],
    );
  }
}
