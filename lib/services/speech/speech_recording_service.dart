/// Platform recording boundary (audio file for speech *analysis*).
///
/// For dictation / TextField STT use the global VoiceInputService instead —
/// do not create a second recognizer.
library;

import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';

/// Platform recording boundary.
///
/// Concrete mic/file implementation is wired in a later milestone.
/// Architecture owns the contract so Conversation Sessions can depend on it now.
/// Pronunciation exercises that need spoken *text* should call
/// VoiceInputService (shared offline Vosk STT), not a parallel ASR stack.
abstract class SpeechRecordingService {
  Future<Result<void>> start();
  Future<Result<SpeechRecordingResult>> stop();
  Future<Result<void>> cancel();
  bool get isRecording;
}

class SpeechRecordingResult {
  const SpeechRecordingResult({
    required this.audioPath,
    required this.durationMs,
    this.amplitudes = const [],
  });

  final String audioPath;
  final int durationMs;
  final List<double> amplitudes;
}

/// Offline stub used until platform recorder plugins are integrated.
class StubSpeechRecordingService implements SpeechRecordingService {
  bool _recording = false;
  DateTime? _startedAt;

  @override
  bool get isRecording => _recording;

  @override
  Future<Result<void>> start() async {
    if (_recording) {
      return const Err(PlatformFailure('Recording already in progress'));
    }
    _recording = true;
    _startedAt = DateTime.now();
    return const Success(null);
  }

  @override
  Future<Result<SpeechRecordingResult>> stop() async {
    if (!_recording || _startedAt == null) {
      return const Err(PlatformFailure('No active recording'));
    }
    final duration =
        DateTime.now().difference(_startedAt!).inMilliseconds.clamp(0, 600000);
    _recording = false;
    _startedAt = null;
    return Success(
      SpeechRecordingResult(
        audioPath: '',
        durationMs: duration,
        amplitudes: const [],
      ),
    );
  }

  @override
  Future<Result<void>> cancel() async {
    _recording = false;
    _startedAt = null;
    return const Success(null);
  }
}
