import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/misc_enums.dart';

/// Offline speech metrics for a recording.
///
/// v0.1 uses local heuristics (duration, amplitude proxies).
/// Future versions can enrich via on-device or remote models.
class SpeechAnalysis extends Equatable {
  const SpeechAnalysis({
    required this.id,
    required this.userId,
    required this.createdAt,
    this.sessionId,
    this.messageId,
    this.audioPath,
    this.durationMs = 0,
    this.averageAmplitude = 0,
    this.speakingRatio = 0,
    this.pauseCount = 0,
    this.estimatedWords = 0,
    this.fluencyScore = 0,
    this.clarityScore = 0,
    this.paceWordsPerMinute = 0,
    this.qualityBand = SpeechQualityBand.developing,
    this.notes = const [],
  });

  final String id;
  final String userId;
  final String? sessionId;
  final String? messageId;
  final String? audioPath;
  final int durationMs;
  final double averageAmplitude;
  final double speakingRatio;
  final int pauseCount;
  final int estimatedWords;
  final double fluencyScore;
  final double clarityScore;
  final double paceWordsPerMinute;
  final SpeechQualityBand qualityBand;
  final List<String> notes;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        id,
        userId,
        sessionId,
        messageId,
        audioPath,
        durationMs,
        averageAmplitude,
        speakingRatio,
        pauseCount,
        estimatedWords,
        fluencyScore,
        clarityScore,
        paceWordsPerMinute,
        qualityBand,
        notes,
        createdAt,
      ];
}
