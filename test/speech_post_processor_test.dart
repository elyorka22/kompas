import 'package:flutter_test/flutter_test.dart';
import 'package:kompas/speech/speech_post_processor.dart';

void main() {
  const processor = SpeechPostProcessor();

  test('restores Russian greeting and question punctuation', () {
    final out = processor.process(
      'привет как дела сегодня я ездил в москву потом встретил друга',
    );
    expect(out, contains('Привет'));
    expect(out.contains('?') || out.contains('.'), isTrue);
    expect(out, isNot(contains('  ')));
  });

  test('normalizes whitespace and dashes', () {
    final out = processor.process('привет   —   друг');
    expect(out, isNot(contains('   ')));
    expect(out, contains('—'));
  });
}
