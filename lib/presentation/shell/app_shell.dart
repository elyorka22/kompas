import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/navigation/app_routes.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CompassBottomNavigation(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: CompassNavDestinations.primary,
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
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        CompassSpacing.screenHorizontal,
        CompassSpacing.lg,
        CompassSpacing.screenHorizontal,
        CompassSpacing.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: CompassMark(size: 28),
          ),
          const SizedBox(width: CompassSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: text.headlineMedium),
                if (subtitle != null) Text(subtitle!, style: text.bodyMedium),
              ],
            ),
          ),
          if (trailing != null) trailing!,
          IconButton(
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(CompassIcons.settings),
          ),
        ],
      ),
    );
  }
}
