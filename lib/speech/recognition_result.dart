/// Recognition output from [SpeechEngine].
library;

import 'package:equatable/equatable.dart';

class SpeechSegment extends Equatable {
  const SpeechSegment({
    required this.text,
    this.startMs = 0,
    this.endMs = 0,
    this.confidence,
  });

  final String text;
  final int startMs;
  final int endMs;
  final double? confidence;

  @override
  List<Object?> get props => [text, startMs, endMs, confidence];
}

class RecognitionResult extends Equatable {
  const RecognitionResult({
    required this.rawText,
    required this.normalizedText,
    this.confidence,
    this.segments = const [],
    this.durationMs = 0,
    this.processingTimeMs = 0,
  });

  final String rawText;
  final String normalizedText;
  final double? confidence;
  final List<SpeechSegment> segments;
  final int durationMs;
  final int processingTimeMs;

  /// Prefer normalized Russian text for TextFields.
  String get text =>
      normalizedText.trim().isNotEmpty ? normalizedText.trim() : rawText.trim();

  @override
  List<Object?> get props => [
        rawText,
        normalizedText,
        confidence,
        segments,
        durationMs,
        processingTimeMs,
      ];
}
