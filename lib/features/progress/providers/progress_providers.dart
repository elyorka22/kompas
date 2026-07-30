import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/domain/entities/user_statistics.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/features/progress/domain/usecases/get_user_statistics.dart';

final userStatisticsProvider =
    FutureProvider<UserStatistics?>((ref) async {
  final user = await ref.watch(activeUserProvider.future);
  if (user == null) return null;
  final result = await ref.watch(getUserStatisticsProvider)(
    GetUserStatisticsParams(userId: user.id),
  );
  return result.valueOrNull;
});
