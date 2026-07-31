import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/entities/notebook_item.dart';
import 'package:kompas/domain/enums/memory_enums.dart';
import 'package:kompas/features/notebook/providers/notebook_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/widgets/voice_input_button.dart';

enum _NotebookFilter {
  all,
  words,
  expressions,
  idioms,
  mistakes,
  favorites,
  notes,
}

class NotebookScreen extends ConsumerStatefulWidget {
  const NotebookScreen({super.key});

  @override
  ConsumerState<NotebookScreen> createState() => _NotebookScreenState();
}

class _NotebookScreenState extends ConsumerState<NotebookScreen> {
  final _search = TextEditingController();
  _NotebookFilter _filter = _NotebookFilter.all;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  bool _matches(NotebookItem item, String query, _NotebookFilter filter) {
    final q = query.trim().toLowerCase();
    if (q.isNotEmpty) {
      final hay = '${item.title} ${item.body} ${item.tags.join(' ')}'
          .toLowerCase();
      if (!hay.contains(q)) return false;
    }

    switch (filter) {
      case _NotebookFilter.all:
        return true;
      case _NotebookFilter.favorites:
        return item.isPinned;
      case _NotebookFilter.mistakes:
        return item.type == NotebookItemType.correction;
      case _NotebookFilter.notes:
        return item.type == NotebookItemType.note ||
            item.type == NotebookItemType.idea;
      case _NotebookFilter.expressions:
        return item.type == NotebookItemType.expression ||
            item.tags.any((t) => t.toLowerCase().contains('expression'));
      case _NotebookFilter.idioms:
        return item.tags.any((t) => t.toLowerCase().contains('idiom')) ||
            item.title.toLowerCase().contains('idiom');
      case _NotebookFilter.words:
        return item.type == NotebookItemType.example ||
            item.tags.any((t) => t.toLowerCase().contains('word'));
    }
  }

  String _typeLabel(KompasL10n l10n, NotebookItem item) {
    if (item.isPinned) return l10n.notebookFilterFavorites;
    return switch (item.type) {
      NotebookItemType.expression => l10n.notebookFilterExpressions,
      NotebookItemType.correction => l10n.notebookFilterMistakes,
      NotebookItemType.example => l10n.notebookFilterWords,
      NotebookItemType.note || NotebookItemType.idea => l10n.notebookFilterNotes,
    };
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(notebookItemsProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return CompassPageTemplate(
      header: CompassPageIntro(
        title: l10n.notebookTitle,
        subtitle: l10n.notebookSubtitle,
      ),
      children: [
        CompassSearchField(
          controller: _search,
          hint: l10n.notebookSearchHint,
          onChanged: (_) => setState(() {}),
          suffixIcon: VoiceInputButton(
            controller: _search,
            onTextUpdated: (_) => setState(() {}),
          ),
        ),
        const SizedBox(height: CompassSpacing.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final entry in <(_NotebookFilter, String)>[
                (_NotebookFilter.all, l10n.notebookAll),
                (_NotebookFilter.words, l10n.notebookFilterWords),
                (_NotebookFilter.expressions, l10n.notebookFilterExpressions),
                (_NotebookFilter.idioms, l10n.notebookFilterIdioms),
                (_NotebookFilter.mistakes, l10n.notebookFilterMistakes),
                (_NotebookFilter.favorites, l10n.notebookFilterFavorites),
                (_NotebookFilter.notes, l10n.notebookFilterNotes),
              ]) ...[
                Padding(
                  padding: const EdgeInsets.only(right: CompassSpacing.xs),
                  child: ChoiceChip(
                    label: Text(entry.$2),
                    selected: _filter == entry.$1,
                    onSelected: (_) => setState(() => _filter = entry.$1),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ],
          ),
        ),
        items.when(
          data: (list) {
            if (list.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: CompassSpacing.xl),
                child: Text(l10n.notebookEmpty, style: text.bodyLarge),
              );
            }

            final filtered = list
                .where((item) => _matches(item, _search.text, _filter))
                .toList()
              ..sort((a, b) {
                if (a.isPinned != b.isPinned) {
                  return a.isPinned ? -1 : 1;
                }
                return b.updatedAt.compareTo(a.updatedAt);
              });

            if (filtered.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: CompassSpacing.xl),
                child: Text(l10n.notebookEmpty, style: text.bodyMedium),
              );
            }

            final pinned = filtered.where((i) => i.isPinned).toList();
            final rest = filtered.where((i) => !i.isPinned).toList();

            Widget buildItem(NotebookItem item) {
              return CompassSoftRow(
                title: item.title,
                subtitle: item.body.isEmpty
                    ? _typeLabel(l10n, item)
                    : item.body,
                leading: Icon(
                  item.isPinned
                      ? Icons.push_pin_rounded
                      : Icons.notes_rounded,
                  size: 18,
                  color: scheme.primary.withOpacity(0.8),
                ),
                trailing: Text(
                  _typeLabel(l10n, item),
                  style: text.labelSmall,
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (pinned.isNotEmpty)
                  CompassQuietSection(
                    label: l10n.notebookPinned,
                    child: Column(
                      children: [for (final item in pinned) buildItem(item)],
                    ),
                  ),
                CompassQuietSection(
                  label: pinned.isEmpty
                      ? l10n.notebookAll
                      : l10n.notebookRecent,
                  child: Column(
                    children: [
                      for (final item in (pinned.isEmpty ? filtered : rest))
                        buildItem(item),
                    ],
                  ),
                ),
              ],
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.only(top: CompassSpacing.xl),
            child: LinearProgressIndicator(),
          ),
          error: (error, _) => Text('$error'),
        ),
      ],
    );
  }
}
