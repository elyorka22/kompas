import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/domain/repositories/skill_repository.dart';
import 'package:kompas/shared/catalog/default_skill_catalog.dart';

class SkillTreeSnapshot {
  const SkillTreeSnapshot({
    required this.skills,
    required this.progress,
  });

  final List<Skill> skills;
  final List<SkillProgress> progress;
}

class LoadSkillTreeParams {
  const LoadSkillTreeParams({required this.userId});
  final String userId;
}

class LoadSkillTree extends UseCase<SkillTreeSnapshot, LoadSkillTreeParams> {
  LoadSkillTree({
    required SkillRepository skillRepository,
    required SkillProgressRepository skillProgressRepository,
  })  : _skills = skillRepository,
        _progress = skillProgressRepository;

  final SkillRepository _skills;
  final SkillProgressRepository _progress;

  @override
  Future<Result<SkillTreeSnapshot>> call(LoadSkillTreeParams params) async {
    await _skills.seedIfEmpty(DefaultSkillCatalog.skills);
    final skills = await _skills.listAll();
    if (skills.isFailure) {
      return Err(skills.failureOrNull!);
    }
    final progress = await _progress.listByUser(params.userId);
    if (progress.isFailure) {
      return Err(progress.failureOrNull!);
    }
    return Success(
      SkillTreeSnapshot(
        skills: skills.valueOrNull!,
        progress: progress.valueOrNull!,
      ),
    );
  }
}
