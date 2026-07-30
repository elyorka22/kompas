import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/features/daily_goals/domain/usecases/ensure_daily_missions.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';

final todaysMissionsProvider =
    FutureProvider<List<DailyMission>>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return const [];
  final result = await ref.watch(ensureDailyMissionsProvider)(
    EnsureDailyMissionsParams(userId: user.id),
  );
  return result.valueOrNull ?? const [];
});
