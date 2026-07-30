import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/features/achievements/domain/usecases/load_achievements.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';

final achievementsProvider =
    FutureProvider<AchievementsSnapshot?>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return null;
  final result = await ref.watch(loadAchievementsProvider)(
    LoadAchievementsParams(userId: user.id),
  );
  return result.valueOrNull;
});
