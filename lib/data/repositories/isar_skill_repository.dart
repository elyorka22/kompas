import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/learning_path_collection.dart';
import 'package:kompas/data/local/collections/skill_collection.dart';
import 'package:kompas/data/local/collections/skill_progress_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/learning_path.dart';
import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/domain/repositories/skill_repository.dart';

class IsarSkillRepository implements SkillRepository {
  IsarSkillRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<List<Skill>>> listAll() async {
    try {
      final items =
          await _isar.skillCollections.where().sortByOrder().findAll();
      return Success(items.map(EntityMappers.toSkill).toList());
    } catch (error) {
      return Err(StorageFailure('Failed to list skills', cause: error));
    }
  }

  @override
  Future<Result<Skill>> getById(String id) async {
    try {
      final collection = await _isar.skillCollections
          .filter()
          .domainIdEqualTo(id)
          .findFirst();
      if (collection == null) {
        return const Err(NotFoundFailure('Skill not found'));
      }
      return Success(EntityMappers.toSkill(collection));
    } catch (error) {
      return Err(StorageFailure('Failed to load skill', cause: error));
    }
  }

  @override
  Future<Result<void>> seedIfEmpty(List<Skill> skills) async {
    try {
      final count = await _isar.skillCollections.count();
      if (count > 0) return const Success(null);
      await _isar.writeTxn(() async {
        for (final skill in skills) {
          await _isar.skillCollections.put(EntityMappers.fromSkill(skill));
        }
      });
      return const Success(null);
    } catch (error) {
      return Err(StorageFailure('Failed to seed skills', cause: error));
    }
  }
}

class IsarSkillProgressRepository implements SkillProgressRepository {
  IsarSkillProgressRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<List<SkillProgress>>> listByUser(String userId) async {
    try {
      final items = await _isar.skillProgressCollections
          .filter()
          .userIdEqualTo(userId)
          .findAll();
      return Success(items.map(EntityMappers.toSkillProgress).toList());
    } catch (error) {
      return Err(
        StorageFailure('Failed to list skill progress', cause: error),
      );
    }
  }

  @override
  Future<Result<SkillProgress?>> getForSkill({
    required String userId,
    required String skillId,
  }) async {
    try {
      final collection = await _isar.skillProgressCollections
          .filter()
          .userIdEqualTo(userId)
          .and()
          .skillIdEqualTo(skillId)
          .findFirst();
      if (collection == null) return const Success(null);
      return Success(EntityMappers.toSkillProgress(collection));
    } catch (error) {
      return Err(
        StorageFailure('Failed to load skill progress', cause: error),
      );
    }
  }

  @override
  Future<Result<SkillProgress>> save(SkillProgress progress) async {
    try {
      final existing = await _isar.skillProgressCollections
          .filter()
          .domainIdEqualTo(progress.id)
          .findFirst();
      final mapped =
          EntityMappers.fromSkillProgress(progress, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.skillProgressCollections.put(mapped);
      });
      return Success(progress);
    } catch (error) {
      return Err(
        StorageFailure('Failed to save skill progress', cause: error),
      );
    }
  }
}

class IsarLearningPathRepository implements LearningPathRepository {
  IsarLearningPathRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<List<LearningPath>>> listAll() async {
    try {
      final items = await _isar.learningPathCollections.where().findAll();
      return Success(items.map(EntityMappers.toLearningPath).toList());
    } catch (error) {
      return Err(StorageFailure('Failed to list paths', cause: error));
    }
  }

  @override
  Future<Result<LearningPath?>> getDefault() async {
    try {
      final items = await _isar.learningPathCollections.where().findAll();
      final match = items.where((item) => item.isDefault).toList();
      if (match.isEmpty) return const Success(null);
      return Success(EntityMappers.toLearningPath(match.first));
    } catch (error) {
      return Err(StorageFailure('Failed to load default path', cause: error));
    }
  }

  @override
  Future<Result<UserLearningPath?>> getUserPath(String userId) async {
    try {
      final collection = await _isar.userLearningPathCollections
          .filter()
          .userIdEqualTo(userId)
          .findFirst();
      if (collection == null) return const Success(null);
      return Success(EntityMappers.toUserLearningPath(collection));
    } catch (error) {
      return Err(StorageFailure('Failed to load user path', cause: error));
    }
  }

  @override
  Future<Result<UserLearningPath>> saveUserPath(UserLearningPath path) async {
    try {
      final existing = await _isar.userLearningPathCollections
          .filter()
          .domainIdEqualTo(path.id)
          .findFirst();
      final mapped =
          EntityMappers.fromUserLearningPath(path, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.userLearningPathCollections.put(mapped);
      });
      return Success(path);
    } catch (error) {
      return Err(StorageFailure('Failed to save user path', cause: error));
    }
  }

  @override
  Future<Result<void>> seedIfEmpty(List<LearningPath> paths) async {
    try {
      final count = await _isar.learningPathCollections.count();
      if (count > 0) return const Success(null);
      await _isar.writeTxn(() async {
        for (final path in paths) {
          await _isar.learningPathCollections
              .put(EntityMappers.fromLearningPath(path));
        }
      });
      return const Success(null);
    } catch (error) {
      return Err(StorageFailure('Failed to seed paths', cause: error));
    }
  }
}
