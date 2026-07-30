import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/features/skill_tree/providers/skill_tree_providers.dart';
import 'package:kompas/presentation/shell/app_shell.dart';

class SkillTreeScreen extends ConsumerWidget {
  const SkillTreeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tree = ref.watch(skillTreeProvider);
    final text = Theme.of(context).textTheme;

    return ListView(
      children: [
        const ShellHeader(
          title: 'Skill Tree',
          subtitle: 'Speaking abilities that compound over time',
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
                    'Complete onboarding to unlock your path.',
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
