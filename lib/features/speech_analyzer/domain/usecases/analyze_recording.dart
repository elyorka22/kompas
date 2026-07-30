import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/speech_analysis.dart';
import 'package:kompas/domain/repositories/speech_analysis_repository.dart';
import 'package:kompas/services/speech/speech_analyzer_service.dart';

class AnalyzeRecordingParams {
  const AnalyzeRecordingParams({
    required this.userId,
    required this.durationMs,
    this.amplitudes = const [],
    this.sessionId,
    this.messageId,
    this.audioPath,
  });

  final String userId;
  final int durationMs;
  final List<double> amplitudes;
  final String? sessionId;
  final String? messageId;
  final String? audioPath;
}

class AnalyzeRecording
    extends UseCase<SpeechAnalysis, AnalyzeRecordingParams> {
  AnalyzeRecording({
    required SpeechAnalyzerService analyzer,
    required SpeechAnalysisRepository repository,
  })  : _analyzer = analyzer,
        _repository = repository;

  final SpeechAnalyzerService _analyzer;
  final SpeechAnalysisRepository _repository;

  @override
  Future<Result<SpeechAnalysis>> call(AnalyzeRecordingParams params) async {
    final analysis = _analyzer.analyze(
      userId: params.userId,
      durationMs: params.durationMs,
      amplitudes: params.amplitudes,
      sessionId: params.sessionId,
      messageId: params.messageId,
      audioPath: params.audioPath,
    );
    return _repository.save(analysis);
  }
}
