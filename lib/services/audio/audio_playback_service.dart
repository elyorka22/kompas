/// Playback boundary for recorded speech and coach audio assets.
abstract class AudioPlaybackService {
  Future<void> play(String path);
  Future<void> stop();
  bool get isPlaying;
}

class StubAudioPlaybackService implements AudioPlaybackService {
  bool _playing = false;

  @override
  bool get isPlaying => _playing;

  @override
  Future<void> play(String path) async {
    _playing = true;
  }

  @override
  Future<void> stop() async {
    _playing = false;
  }
}
