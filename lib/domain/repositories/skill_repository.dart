import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/learning_path.dart';
import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/entities/skill_progress.dart';

abstract class SkillRepository {
  Future<Result<List<Skill>>> listAll();
  Future<Result<Skill>> getById(String id);
  Future<Result<void>> seedIfEmpty(List<Skill> skills);
}

abstract class SkillProgressRepository {
  Future<Result<List<SkillProgress>>> listByUser(String userId);
  Future<Result<SkillProgress?>> getForSkill({
    required String userId,
    required String skillId,
  });
  Future<Result<SkillProgress>> save(SkillProgress progress);
}

abstract class LearningPathRepository {
  Future<Result<List<LearningPath>>> listAll();
  Future<Result<LearningPath?>> getDefault();
  Future<Result<UserLearningPath?>> getUserPath(String userId);
  Future<Result<UserLearningPath>> saveUserPath(UserLearningPath path);
  Future<Result<void>> seedIfEmpty(List<LearningPath> paths);
}
