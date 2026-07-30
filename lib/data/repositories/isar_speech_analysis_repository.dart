import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/speech_analysis_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/speech_analysis.dart';
import 'package:kompas/domain/repositories/speech_analysis_repository.dart';

class IsarSpeechAnalysisRepository implements SpeechAnalysisRepository {
  IsarSpeechAnalysisRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<SpeechAnalysis>> save(SpeechAnalysis analysis) async {
    try {
      final existing = await _isar.speechAnalysisCollections
          .filter()
          .domainIdEqualTo(analysis.id)
          .findFirst();
      final mapped =
          EntityMappers.fromSpeechAnalysis(analysis, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.speechAnalysisCollections.put(mapped);
      });
      return Success(analysis);
    } catch (error) {
      return Err(
        StorageFailure('Failed to save speech analysis', cause: error),
      );
    }
  }

  @override
  Future<Result<SpeechAnalysis>> getById(String id) async {
    try {
      final collection = await _isar.speechAnalysisCollections
          .filter()
          .domainIdEqualTo(id)
          .findFirst();
      if (collection == null) {
        return const Err(NotFoundFailure('Speech analysis not found'));
      }
      return Success(EntityMappers.toSpeechAnalysis(collection));
    } catch (error) {
      return Err(
        StorageFailure('Failed to load speech analysis', cause: error),
      );
    }
  }

  @override
  Future<Result<List<SpeechAnalysis>>> listByUser(
    String userId, {
    int limit = 50,
  }) async {
    try {
      final items = await _isar.speechAnalysisCollections
          .filter()
          .userIdEqualTo(userId)
          .sortByCreatedAtDesc()
          .findAll();
      return Success(
        items.take(limit).map(EntityMappers.toSpeechAnalysis).toList(),
      );
    } catch (error) {
      return Err(
        StorageFailure('Failed to list speech analyses', cause: error),
      );
    }
  }
}
