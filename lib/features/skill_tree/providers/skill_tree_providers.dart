import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/features/skill_tree/domain/usecases/load_skill_tree.dart';

final skillTreeProvider = FutureProvider<SkillTreeSnapshot?>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return null;
  final result = await ref.watch(loadSkillTreeProvider)(
    LoadSkillTreeParams(userId: user.id),
  );
  return result.valueOrNull;
});
