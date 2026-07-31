/// Russian speech typography / punctuation normalizer.
library;

/// Restores readable Russian punctuation for Whisper raw transcripts.
class SpeechPostProcessor {
  const SpeechPostProcessor();

  String process(String raw) {
    var text = raw.trim();
    if (text.isEmpty) return '';

    text = text.replaceAll(RegExp(r'\s+'), ' ');
    text = text.replaceAll('« ', '«').replaceAll(' »', '»');
    text = text.replaceAll(RegExp('[“”]'), '"');
    text = text.replaceAll(RegExp('[‘’‛]'), "'");
    text = text.replaceAll(RegExp(r'[–—−]'), '—');
    text = text.replaceAll(RegExp(r'\s+([,.;:!?…])'), r'$1');
    text = text.replaceAll(RegExp(r'([«])\s+'), r'$1');
    text = text.replaceAll(RegExp(r'\s+([»])'), r'$1');

    if (RegExp(r'[.!?…]').hasMatch(text)) {
      return _capitalizeSentences(_ensureTerminalPunctuation(text));
    }

    return _capitalizeSentences(_heuristicPunctuate(text));
  }

  String _ensureTerminalPunctuation(String text) {
    final trimmed = text.trimRight();
    if (trimmed.isEmpty) return trimmed;
    if (RegExp(r'[.!?…]$').hasMatch(trimmed)) return trimmed;
    return '$trimmed.';
  }

  /// Lightweight Russian clause splitter for unpunctuated ASR dumps.
  String _heuristicPunctuate(String text) {
    final words = text.split(' ');
    if (words.isEmpty) return text;

    final buffer = StringBuffer();
    var sentenceLen = 0;
    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      final lower = word.toLowerCase();
      final isBoundaryStarter = sentenceLen > 3 &&
          (lower == 'привет' ||
              lower == 'здравствуйте' ||
              lower == 'сегодня' ||
              lower == 'потом' ||
              lower == 'затем' ||
              lower == 'поэтому' ||
              lower == 'кроме' ||
              lower == 'однако' ||
              lower == 'кстати');

      if (buffer.isNotEmpty) {
        if (isBoundaryStarter) {
          buffer.write('. ');
          sentenceLen = 0;
        } else if (sentenceLen >= 14 &&
            (lower == 'и' || lower == 'а' || lower == 'но')) {
          buffer.write(', ');
        } else {
          buffer.write(' ');
        }
      }

      buffer.write(word);
      sentenceLen++;
    }

    var out = buffer.toString().trim();
    final lower = out.toLowerCase();
    if (lower.contains('как дела') ||
        lower.startsWith('что ') ||
        lower.startsWith('где ') ||
        lower.startsWith('почему') ||
        lower.contains('можно ли')) {
      out = '${out.replaceAll(RegExp(r'[.!?…]*$'), '')}?';
    } else if (RegExp(
      r'^(привет|здравствуй|добрый|хай)\b',
      caseSensitive: false,
    ).hasMatch(out)) {
      out = out.replaceFirstMapped(
        RegExp(
          r'^(привет|здравствуй(?:те)?|добрый\s+\w+|хай)\b',
          caseSensitive: false,
        ),
        (m) => '${m.group(0)}!',
      );
      if (!RegExp(r'[.!?…]$').hasMatch(out)) {
        out = '$out.';
      }
    } else {
      out = _ensureTerminalPunctuation(out);
    }

    return out;
  }

  String _capitalizeSentences(String text) {
    final parts = text.split(RegExp(r'(?<=[.!?…])\s+'));
    return parts.map(_capitalizeFirst).join(' ');
  }

  String _capitalizeFirst(String part) {
    final p = part.trim();
    if (p.isEmpty) return p;
    final runes = p.runes.toList();
    final first = String.fromCharCode(runes.first).toUpperCase();
    final rest =
        runes.length > 1 ? String.fromCharCodes(runes.skip(1)) : '';
    return '$first$rest';
  }
}
