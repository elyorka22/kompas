import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/entities/notebook_item.dart';
import 'package:kompas/domain/enums/memory_enums.dart';
import 'package:kompas/features/notebook/domain/notebook_vocab_entry.dart';
import 'package:kompas/features/notebook/domain/usecases/save_notebook_item.dart';
import 'package:kompas/features/notebook/providers/notebook_providers.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
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
    final entry = NotebookVocabEntry.fromItem(item);
    final hay =
        '${entry.word} ${entry.translation} ${entry.examples.join(' ')}'
            .toLowerCase();
    return hay.contains(q);
  }

  Future<void> _openAddSheet() async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const _AddVocabSheet(),
    );
    if (saved == true) {
      ref.invalidate(notebookItemsProvider);
    }
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddSheet,
        tooltip: l10n.notebookAddWord,
        icon: const Icon(Icons.add_rounded, size: 28),
        label: Text(l10n.notebookAddWord),
      ),
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
            const SizedBox(height: CompassSpacing.sm),
            Text(
              l10n.notebookChatHint,
              style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: CompassSpacing.lg),
            CompassSearchField(
              controller: _search,
              hint: l10n.notebookSearchHint,
              onChanged: (_) => setState(() {}),
              suffixIcon: VoiceInputButton(
                controller: _search,
                compact: true,
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
                    for (final item in filtered) ...[
                      _VocabCard(entry: NotebookVocabEntry.fromItem(item)),
                      const SizedBox(height: CompassSpacing.md),
                    ],
                    const SizedBox(height: CompassSpacing.xxl),
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

class _VocabCard extends StatelessWidget {
  const _VocabCard({required this.entry});

  final NotebookVocabEntry entry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(CompassSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withOpacity(0.45),
        borderRadius: BorderRadius.circular(CompassRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.word,
            style: text.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          if (entry.translation.isNotEmpty) ...[
            const SizedBox(height: CompassSpacing.xs),
            Text(
              entry.translation,
              style: text.titleMedium?.copyWith(color: scheme.primary),
            ),
          ],
          if (entry.examples.isNotEmpty) ...[
            const SizedBox(height: CompassSpacing.md),
            Text(
              KompasL10n.of(context).notebookExamples,
              style: text.labelLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: CompassSpacing.sm),
            for (final example in entry.examples)
              Padding(
                padding: const EdgeInsets.only(bottom: CompassSpacing.xs),
                child: Text('• $example', style: text.bodyMedium),
              ),
          ],
        ],
      ),
    );
  }
}

class _AddVocabSheet extends ConsumerStatefulWidget {
  const _AddVocabSheet();

  @override
  ConsumerState<_AddVocabSheet> createState() => _AddVocabSheetState();
}

class _AddVocabSheetState extends ConsumerState<_AddVocabSheet> {
  final _word = TextEditingController();
  final _translation = TextEditingController();
  final _example1 = TextEditingController();
  final _example2 = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _word.dispose();
    _translation.dispose();
    _example1.dispose();
    _example2.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final word = _word.text.trim();
    if (word.isEmpty || _saving) return;
    final user = await ref.read(activeUserProvider.future);
    if (user == null || !mounted) return;

    setState(() => _saving = true);
    final entry = NotebookVocabEntry(
      word: word,
      translation: _translation.text.trim(),
      examples: [
        _example1.text.trim(),
        _example2.text.trim(),
      ].where((e) => e.isNotEmpty).toList(),
    );

    final result = await ref.read(saveNotebookItemProvider)(
      SaveNotebookItemParams(
        userId: user.id,
        title: entry.word,
        body: entry.encodeBody(),
        type: NotebookItemType.expression,
        tags: const ['vocab', 'manual'],
      ),
    );

    if (!mounted) return;
    setState(() => _saving = false);
    result.fold(
      onSuccess: (_) => Navigator.of(context).pop(true),
      onFailure: (failure) {
        CompassSnackbars.show(context, message: failure.message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = KompasL10n.of(context);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        CompassSpacing.lg,
        CompassSpacing.md,
        CompassSpacing.lg,
        CompassSpacing.lg + bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CompassSheetHandle(),
            Text(l10n.notebookAddWord, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: CompassSpacing.md),
            TextField(
              controller: _word,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: l10n.notebookWordLabel),
            ),
            const SizedBox(height: CompassSpacing.sm),
            TextField(
              controller: _translation,
              decoration:
                  InputDecoration(labelText: l10n.notebookTranslationLabel),
            ),
            const SizedBox(height: CompassSpacing.sm),
            TextField(
              controller: _example1,
              decoration:
                  InputDecoration(labelText: l10n.notebookExampleLabel(1)),
            ),
            const SizedBox(height: CompassSpacing.sm),
            TextField(
              controller: _example2,
              decoration:
                  InputDecoration(labelText: l10n.notebookExampleLabel(2)),
            ),
            const SizedBox(height: CompassSpacing.lg),
            CompassPrimaryButton(
              label: _saving ? l10n.saving : l10n.save,
              onPressed: _saving ? null : _save,
            ),
          ],
        ),
      ),
    );
  }
}
