/// Immutable snapshot of the global offline voice-input pipeline.
///
/// Consumed by Riverpod UI; produced by [VoiceInputService].
library;

enum VoiceStatus {
  /// Plugin / model not loaded yet.
  idle,

  /// Model is loading (first call only).
  initializing,

  /// Ready to listen.
  ready,

  /// Microphone is open; partial results may stream.
  listening,

  /// Transient work between stop and final flush.
  processing,

  /// Recoverable failure (permission, missing model, init, etc.).
  error,
}

class VoiceState {
  const VoiceState({
    this.status = VoiceStatus.idle,
    this.partialText = '',
    this.committedText = '',
    this.errorMessage,
    this.isModelLoaded = false,
  });

  final VoiceStatus status;
  final String partialText;

  /// Finalized segments accumulated during the current listening session.
  final String committedText;
  final String? errorMessage;
  final bool isModelLoaded;

  /// Best live draft for TextField binding: committed + current partial.
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
      status == VoiceStatus.processing;
  bool get hasError => status == VoiceStatus.error;

  VoiceState copyWith({
    VoiceStatus? status,
    String? partialText,
    String? committedText,
    String? errorMessage,
    bool? isModelLoaded,
    bool clearError = false,
  }) {
    return VoiceState(
      status: status ?? this.status,
      partialText: partialText ?? this.partialText,
      committedText: committedText ?? this.committedText,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isModelLoaded: isModelLoaded ?? this.isModelLoaded,
    );
  }

  @override
  String toString() =>
      'VoiceState(status: $status, live: "$liveText", error: $errorMessage)';
}
