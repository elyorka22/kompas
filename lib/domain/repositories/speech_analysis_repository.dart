import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/speech_analysis.dart';

abstract class SpeechAnalysisRepository {
  Future<Result<SpeechAnalysis>> save(SpeechAnalysis analysis);
  Future<Result<SpeechAnalysis>> getById(String id);
  Future<Result<List<SpeechAnalysis>>> listByUser(
    String userId, {
    int limit = 50,
  });
}
