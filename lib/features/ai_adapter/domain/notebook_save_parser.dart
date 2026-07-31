/// Parses machine notebook-save blocks from coach replies.
library;

import 'dart:convert';

import 'package:kompas/features/notebook/domain/notebook_vocab_entry.dart';

final _notebookSavePattern = RegExp(
  r'<<<NOTEBOOK_SAVE>>>\s*(\{.*?\})\s*<<<END_NOTEBOOK_SAVE>>>',
  dotAll: true,
);

class NotebookSaveParseResult {
  const NotebookSaveParseResult({
    required this.visibleText,
    required this.entries,
  });

  final String visibleText;
  final List<NotebookVocabEntry> entries;
}

/// Extracts zero or more notebook saves and strips them from visible chat text.
NotebookSaveParseResult parseNotebookSaves(String raw) {
  final entries = <NotebookVocabEntry>[];
  var visible = raw;

  for (final match in _notebookSavePattern.allMatches(raw)) {
    final jsonText = match.group(1);
    if (jsonText == null) continue;
    try {
      final map = jsonDecode(jsonText) as Map<String, dynamic>;
      final word = (map['word'] as String?)?.trim() ?? '';
      final translation = (map['translation'] as String?)?.trim() ?? '';
      final examplesRaw = map['examples'];
      final examples = <String>[];
      if (examplesRaw is List) {
        for (final e in examplesRaw) {
          final s = e.toString().trim();
          if (s.isNotEmpty) examples.add(s);
        }
      }
      if (word.isEmpty) continue;
      entries.add(
        NotebookVocabEntry(
          word: word,
          translation: translation,
          examples: examples,
        ),
      );
    } catch (_) {
      // Ignore malformed blocks; keep original text for that span.
      continue;
    }
  }

  if (entries.isNotEmpty) {
    visible = raw.replaceAll(_notebookSavePattern, '').trim();
    visible = visible.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
  }

  return NotebookSaveParseResult(visibleText: visible, entries: entries);
}
