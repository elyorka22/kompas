import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/features/notebook/providers/notebook_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/presentation/shell/app_shell.dart';

class NotebookScreen extends ConsumerWidget {
  const NotebookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(notebookItemsProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;

    return ListView(
      children: [
        ShellHeader(
          title: l10n.notebookTitle,
          subtitle: l10n.notebookSubtitle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CompassSpacing.screenHorizontal,
          ),
          child: items.when(
            data: (list) {
              if (list.isEmpty) {
                return CompassCard(
                  child: Text(
                    l10n.notebookEmpty,
                    style: text.bodyMedium,
                  ),
                );
              }
              return Column(
                children: list
                    .map(
                      (item) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: CompassSpacing.sm),
                        child: CompassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: text.titleMedium),
                              if (item.body.isNotEmpty) ...[
                                const SizedBox(height: CompassSpacing.xs),
                                Text(item.body, style: text.bodyMedium),
                              ],
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
