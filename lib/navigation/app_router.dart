import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/features/conversation/presentation/screens/coach_chat_screen.dart';
import 'package:kompas/features/conversation/presentation/screens/practice_screen.dart';
import 'package:kompas/features/conversation/presentation/screens/session_complete_screen.dart';
import 'package:kompas/features/conversation/presentation/screens/session_screen.dart';
import 'package:kompas/features/notebook/presentation/screens/notebook_screen.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/features/progress/presentation/screens/progress_screen.dart';
import 'package:kompas/features/settings/presentation/screens/settings_screen.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
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
      final location = state.matchedLocation;
      final atSplash = location == AppRoutes.splash;

      if (status.isLoading || status.hasError) {
        return atSplash ? null : AppRoutes.splash;
      }

      final ready = status.value ?? false;
      if (!ready) {
        // Still bootstrapping local user — stay on splash.
        return atSplash ? null : AppRoutes.splash;
      }
      if (atSplash ||
          location == AppRoutes.onboarding ||
          location == AppRoutes.welcomeMission) {
        return AppRoutes.coach;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) => CompassPageTransitions.fadeScale(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.sessionComplete,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return CompassPageTransitions.fadeScale(
            key: state.pageKey,
            child: SessionCompleteScreen(sessionId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.session,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return CompassPageTransitions.fadeSlide(
            key: state.pageKey,
            child: SessionScreen(sessionId: id),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.coach,
                builder: (context, state) => const CoachChatScreen(),
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
                path: AppRoutes.progress,
                builder: (context, state) => const ProgressScreen(),
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
        ],
      ),
    ],
  );
});

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: CompassMotion.compassSpin,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: _controller,
            curve: CompassMotion.standard,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CompassWidget(size: 88),
              const SizedBox(height: CompassSpacing.lg),
              Text(
                l10n.appName,
                style: text.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: CompassSpacing.xs),
              Text(
                l10n.splashTagline,
                style: text.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
