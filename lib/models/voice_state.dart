/// UI-facing snapshot for the mic button (backed by [SpeechEngine]).
library;

enum VoiceStatus {
  idle,
  initializing,
  ready,
  listening,
  processing,
  downloading,
  error,
}

class VoiceState {
  const VoiceState({
    this.status = VoiceStatus.idle,
    this.partialText = '',
    this.committedText = '',
    this.errorMessage,
    this.isModelLoaded = false,
    this.downloadProgress = 0,
  });

  final VoiceStatus status;
  final String partialText;
  final String committedText;
  final String? errorMessage;
  final bool isModelLoaded;
  final double downloadProgress;

  String get liveText {
    final committed = committedText.trim();
    final partial = partialText.trim();
    if (committed.isEmpty) return partial;
    if (partial.isEmpty) return committed;
    return '$committed $partial';
  }

  bool get isListening => status == VoiceStatus.listening;
  bool get isBusy =>
      status == VoiceStatus.initializing ||
      status == VoiceStatus.listening ||
      status == VoiceStatus.processing ||
      status == VoiceStatus.downloading;
  bool get hasError => status == VoiceStatus.error;

  VoiceState copyWith({
    VoiceStatus? status,
    String? partialText,
    String? committedText,
    String? errorMessage,
    bool? isModelLoaded,
    double? downloadProgress,
    bool clearError = false,
  }) {
    return VoiceState(
      status: status ?? this.status,
      partialText: partialText ?? this.partialText,
      committedText: committedText ?? this.committedText,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isModelLoaded: isModelLoaded ?? this.isModelLoaded,
      downloadProgress: downloadProgress ?? this.downloadProgress,
    );
  }
}
