import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/design_system/icons/compass_mark.dart';
import 'package:kompas/features/conversation/presentation/screens/practice_screen.dart';
import 'package:kompas/features/daily_goals/presentation/screens/home_screen.dart';
import 'package:kompas/features/notebook/presentation/screens/notebook_screen.dart';
import 'package:kompas/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/features/progress/presentation/screens/progress_screen.dart';
import 'package:kompas/features/settings/presentation/screens/settings_screen.dart';
import 'package:kompas/features/skill_tree/presentation/screens/skill_tree_screen.dart';
import 'package:kompas/navigation/app_routes.dart';
import 'package:kompas/presentation/shell/app_shell.dart';

final _rootKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final auth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());

  ref.listen<AsyncValue<bool>>(hasCompletedOnboardingProvider, (_, next) {
    auth.value = next;
  });
  auth.value = ref.read(hasCompletedOnboardingProvider);

  ref.onDispose(auth.dispose);

  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: auth,
    redirect: (context, state) {
      final status = auth.value;
      final loggingIn = state.matchedLocation == AppRoutes.onboarding;
      final atSplash = state.matchedLocation == AppRoutes.splash;

      if (status.isLoading || status.hasError) {
        return atSplash ? null : AppRoutes.splash;
      }

      final onboarded = status.value ?? false;
      if (!onboarded) {
        return loggingIn ? null : AppRoutes.onboarding;
      }
      if (loggingIn || atSplash) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const _SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.practice,
                builder: (context, state) => const PracticeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.notebook,
                builder: (context, state) => const NotebookScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.skills,
                builder: (context, state) => const SkillTreeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.progress,
                builder: (context, state) => const ProgressScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CompassMark(size: 72),
      ),
    );
  }
}
