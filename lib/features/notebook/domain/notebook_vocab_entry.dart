/// Structured vocabulary capture stored in [NotebookItem] title/body.
library;

import 'dart:convert';

import 'package:kompas/domain/entities/notebook_item.dart';

class NotebookVocabEntry {
  const NotebookVocabEntry({
    required this.word,
    required this.translation,
    this.examples = const [],
  });

  final String word;
  final String translation;
  final List<String> examples;

  String encodeBody() {
    return jsonEncode({
      'v': 1,
      'translation': translation.trim(),
      'examples': [
        for (final e in examples)
          if (e.trim().isNotEmpty) e.trim(),
      ],
    });
  }

  /// Parses structured body, or falls back to plain-text body as translation.
  static NotebookVocabEntry fromItem(NotebookItem item) {
    final title = item.title.trim();
    final body = item.body.trim();
    if (body.startsWith('{')) {
      try {
        final map = jsonDecode(body) as Map<String, dynamic>;
        final examplesRaw = map['examples'];
        final examples = <String>[];
        if (examplesRaw is List) {
          for (final e in examplesRaw) {
            final s = e.toString().trim();
            if (s.isNotEmpty) examples.add(s);
          }
        }
        return NotebookVocabEntry(
          word: title,
          translation: (map['translation'] as String?)?.trim() ?? '',
          examples: examples,
        );
      } catch (_) {
        // Fall through to plain text.
      }
    }

    // Legacy / free-form: first line translation, rest examples.
    final lines = body
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
    var translation = '';
    final examples = <String>[];
    for (final line in lines) {
      final lower = line.toLowerCase();
      if (lower.startsWith('перевод:')) {
        translation = line.substring(line.indexOf(':') + 1).trim();
      } else if (lower.startsWith('примеры:')) {
        continue;
      } else if (line.startsWith('•') ||
          line.startsWith('-') ||
          RegExp(r'^\d+[.)]').hasMatch(line)) {
        examples.add(line.replaceFirst(RegExp(r'^[•\-\d.)\s]+'), '').trim());
      } else if (translation.isEmpty) {
        translation = line;
      } else {
        examples.add(line);
      }
    }

    return NotebookVocabEntry(
      word: title,
      translation: translation,
      examples: examples,
    );
  }
}
