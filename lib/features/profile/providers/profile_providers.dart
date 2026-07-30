import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/user.dart';

/// Bootstrap session state: active local user or null before onboarding.
final activeUserProvider = FutureProvider<User?>((ref) async {
  final result = await ref.watch(getActiveUserProvider)(const NoParams());
  return result.valueOrNull;
});

final hasCompletedOnboardingProvider = Provider<AsyncValue<bool>>((ref) {
  return ref.watch(activeUserProvider).whenData(
        (user) => user?.onboardingCompleted ?? false,
      );
});
