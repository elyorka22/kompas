import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/entities/notebook_item.dart';
import 'package:kompas/features/notebook/providers/notebook_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/widgets/voice_input_button.dart';

class NotebookScreen extends ConsumerStatefulWidget {
  const NotebookScreen({super.key});

  @override
  ConsumerState<NotebookScreen> createState() => _NotebookScreenState();
}

class _NotebookScreenState extends ConsumerState<NotebookScreen> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  bool _matches(NotebookItem item, String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    final hay = '${item.title} ${item.body} ${item.tags.join(' ')}'.toLowerCase();
    return hay.contains(q);
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(notebookItemsProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final query = _search.text;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
          children: [
            Text(l10n.notebookTitle, style: text.headlineSmall),
            const SizedBox(height: CompassSpacing.xs),
            Text(
              l10n.notebookSubtitle,
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: CompassSpacing.lg),
            CompassSearchField(
              controller: _search,
              hint: l10n.notebookSearchHint,
              onChanged: (_) => setState(() {}),
              suffixIcon: VoiceInputButton(
                controller: _search,
                onTextUpdated: (_) => setState(() {}),
              ),
            ),
            const SizedBox(height: CompassSpacing.lg),
            items.when(
              data: (list) {
                final filtered =
                    list.where((item) => _matches(item, query)).toList();
                if (filtered.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: CompassSpacing.xl),
                    child: Text(
                      l10n.notebookEmpty,
                      style: text.bodyLarge?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    for (final item in filtered)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(item.title),
                        subtitle: item.body.trim().isEmpty
                            ? null
                            : Text(
                                item.body,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                      ),
                  ],
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('$e'),
            ),
          ],
        ),
      ),
    );
  }
}
