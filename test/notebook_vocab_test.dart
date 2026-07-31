import 'package:flutter_test/flutter_test.dart';
import 'package:kompas/domain/entities/notebook_item.dart';
import 'package:kompas/domain/enums/memory_enums.dart';
import 'package:kompas/features/ai_adapter/domain/notebook_save_parser.dart';
import 'package:kompas/features/notebook/domain/notebook_vocab_entry.dart';

void main() {
  test('parses notebook save block and strips it from visible text', () {
    const raw = '''
Готово! Добавил слово в блокнот.

<<<NOTEBOOK_SAVE>>>
{"word":"небоскрёб","translation":"skyscraper","examples":["В Москве много небоскрёбов.","Этот небоскрёб очень высокий."]}
<<<END_NOTEBOOK_SAVE>>>
''';
    final parsed = parseNotebookSaves(raw);
    expect(parsed.entries, hasLength(1));
    expect(parsed.entries.first.word, 'небоскрёб');
    expect(parsed.entries.first.translation, 'skyscraper');
    expect(parsed.entries.first.examples, hasLength(2));
    expect(parsed.visibleText.contains('NOTEBOOK_SAVE'), isFalse);
    expect(parsed.visibleText.contains('Готово'), isTrue);
  });

  test('encodes and decodes vocab body', () {
    const entry = NotebookVocabEntry(
      word: 'небоскрёб',
      translation: 'skyscraper',
      examples: ['Пример один.', 'Пример два.'],
    );
    final item = NotebookItem(
      id: '1',
      userId: 'u',
      type: NotebookItemType.expression,
      title: entry.word,
      body: entry.encodeBody(),
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );
    final decoded = NotebookVocabEntry.fromItem(item);
    expect(decoded.word, 'небоскрёб');
    expect(decoded.translation, 'skyscraper');
    expect(decoded.examples, ['Пример один.', 'Пример два.']);
  });
}
