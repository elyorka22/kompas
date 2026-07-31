import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/navigation/app_routes.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = KompasL10n.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.black.withOpacity(0.06)),
          ),
        ),
        child: CompassBottomNavigation(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,
          destinations: [
            CompassBottomDestination(
              label: l10n.navCoach,
              icon: CompassIcons.practice,
              selectedIcon: CompassIcons.practiceFilled,
            ),
            CompassBottomDestination(
              label: l10n.navNotebook,
              icon: CompassIcons.notebook,
              selectedIcon: CompassIcons.notebookFilled,
            ),
            CompassBottomDestination(
              label: l10n.navProgress,
              icon: CompassIcons.progress,
              selectedIcon: CompassIcons.progressFilled,
            ),
            CompassBottomDestination(
              label: l10n.navMissions,
              icon: CompassIcons.home,
              selectedIcon: CompassIcons.homeFilled,
            ),
          ],
        ),
      ),
    );
  }
}

/// Shared page header used by shell tab screens.
class ShellHeader extends StatelessWidget {
  const ShellHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        CompassSpacing.screenHorizontal,
        CompassSpacing.lg,
        CompassSpacing.screenHorizontal,
        CompassSpacing.md,
      ),
      child: CompassPageIntro(
        title: title,
        subtitle: subtitle,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailing != null) trailing!,
            IconButton(
              tooltip: KompasL10n.of(context).settings,
              onPressed: () => context.push(AppRoutes.settings),
              icon: const Icon(CompassIcons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
