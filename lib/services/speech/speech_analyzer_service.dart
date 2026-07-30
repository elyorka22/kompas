import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/speech_analysis.dart';
import 'package:kompas/domain/enums/misc_enums.dart';

/// Local speech heuristics for MVP (no cloud ASR / LLM).
///
/// Accepts duration and optional amplitude samples from the recorder and
/// produces coach-readable metrics that Progress and Sessions can store.
class SpeechAnalyzerService {
  SpeechAnalysis analyze({
    required String userId,
    required int durationMs,
    List<double> amplitudes = const [],
    String? sessionId,
    String? messageId,
    String? audioPath,
  }) {
    final averageAmplitude = amplitudes.isEmpty
        ? 0.0
        : amplitudes.reduce((a, b) => a + b) / amplitudes.length;

    const silenceThreshold = 0.08;
    final speakingFrames =
        amplitudes.where((value) => value >= silenceThreshold).length;
    final speakingRatio = amplitudes.isEmpty
        ? 1.0
        : speakingFrames / amplitudes.length;

    var pauseCount = 0;
    var inPause = false;
    for (final value in amplitudes) {
      if (value < silenceThreshold) {
        if (!inPause) {
          pauseCount += 1;
          inPause = true;
        }
      } else {
        inPause = false;
      }
    }

    final durationSeconds = durationMs / 1000.0;
    final estimatedWords = (durationSeconds * speakingRatio * 2.2).round();
    final pace = durationSeconds <= 0
        ? 0.0
        : (estimatedWords / durationSeconds) * 60.0;

    final fluencyScore = _clamp01(
      (speakingRatio * 0.55) +
          (_paceScore(pace) * 0.25) +
          (_pauseScore(pauseCount, durationSeconds) * 0.20),
    );
    final clarityScore = _clamp01(
      (averageAmplitude.clamp(0.0, 1.0) * 0.7) + (speakingRatio * 0.3),
    );

    final qualityBand = _bandFor((fluencyScore + clarityScore) / 2);

    return SpeechAnalysis(
      id: IdGenerator.v4(),
      userId: userId,
      sessionId: sessionId,
      messageId: messageId,
      audioPath: audioPath,
      durationMs: durationMs,
      averageAmplitude: averageAmplitude,
      speakingRatio: speakingRatio,
      pauseCount: pauseCount,
      estimatedWords: estimatedWords,
      fluencyScore: fluencyScore,
      clarityScore: clarityScore,
      paceWordsPerMinute: pace,
      qualityBand: qualityBand,
      notes: _notesFor(qualityBand, pace, pauseCount),
      createdAt: DateTime.now().toUtc(),
    );
  }

  double _paceScore(double wpm) {
    if (wpm < 60) return 0.35;
    if (wpm < 90) return 0.65;
    if (wpm <= 150) return 1.0;
    if (wpm <= 180) return 0.7;
    return 0.4;
  }

  double _pauseScore(int pauses, double durationSeconds) {
    if (durationSeconds <= 0) return 0.5;
    final perMinute = pauses / (durationSeconds / 60.0);
    if (perMinute <= 4) return 1.0;
    if (perMinute <= 8) return 0.7;
    return 0.4;
  }

  SpeechQualityBand _bandFor(double score) {
    if (score < 0.35) return SpeechQualityBand.needsWork;
    if (score < 0.5) return SpeechQualityBand.developing;
    if (score < 0.7) return SpeechQualityBand.solid;
    if (score < 0.85) return SpeechQualityBand.strong;
    return SpeechQualityBand.excellent;
  }

  List<String> _notesFor(
    SpeechQualityBand band,
    double pace,
    int pauses,
  ) {
    final notes = <String>[];
    if (pace < 80) notes.add('Try speaking a little faster to build fluency.');
    if (pace > 170) notes.add('Slow down slightly for clearer articulation.');
    if (pauses > 10) notes.add('Reduce long pauses by preparing key phrases.');
    if (band == SpeechQualityBand.excellent) {
      notes.add('Strong delivery. Capture useful phrases in your notebook.');
    }
    if (notes.isEmpty) {
      notes.add('Solid attempt. Repeat with a clearer structure next time.');
    }
    return notes;
  }

  double _clamp01(double value) {
    if (value < 0) return 0;
    if (value > 1) return 1;
    return value;
  }
}
