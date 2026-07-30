import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/features/notebook/providers/notebook_providers.dart';
import 'package:kompas/presentation/shell/app_shell.dart';

class NotebookScreen extends ConsumerWidget {
  const NotebookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(notebookItemsProvider);
    final text = Theme.of(context).textTheme;

    return ListView(
      children: [
        const ShellHeader(
          title: 'Notebook',
          subtitle: 'Expressions, notes, and corrections',
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
                    'Save phrases as you practice. Memory Engine will schedule reviews.',
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
