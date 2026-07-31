import 'package:flutter_test/flutter_test.dart';
import 'package:kompas/models/voice_state.dart';

void main() {
  group('VoiceState', () {
    test('liveText joins committed and partial', () {
      const state = VoiceState(
        status: VoiceStatus.listening,
        committedText: 'привет',
        partialText: 'мир',
      );
      expect(state.liveText, 'привет мир');
      expect(state.isListening, isTrue);
    });

    test('copyWith can clear error', () {
      const err = VoiceState(
        status: VoiceStatus.error,
        errorMessage: 'boom',
      );
      final next = err.copyWith(
        status: VoiceStatus.ready,
        clearError: true,
      );
      expect(next.errorMessage, isNull);
      expect(next.hasError, isFalse);
    });
  });
}
