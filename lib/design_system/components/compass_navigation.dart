import 'package:flutter/material.dart';
import 'package:kompas/design_system/icons/compass_icons.dart';
import 'package:kompas/design_system/motion/compass_interactions.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_semantic_colors.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

class CompassBottomDestination {
  const CompassBottomDestination({
    required this.label,
    required this.icon,
    this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData? selectedIcon;
}

class CompassBottomNavigation extends StatelessWidget {
  const CompassBottomNavigation({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final List<CompassBottomDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        for (final item in destinations)
          NavigationDestination(
            icon: Icon(item.icon),
            selectedIcon: Icon(item.selectedIcon ?? item.icon),
            label: item.label,
          ),
      ],
    );
  }
}

/// Default Kompas destinations — reuse without inventing icons.
abstract final class CompassNavDestinations {
  static const home = CompassBottomDestination(
    label: 'Home',
    icon: CompassIcons.home,
    selectedIcon: CompassIcons.homeFilled,
  );
  static const practice = CompassBottomDestination(
    label: 'Practice',
    icon: CompassIcons.practice,
    selectedIcon: CompassIcons.practiceFilled,
  );
  static const notebook = CompassBottomDestination(
    label: 'Notebook',
    icon: CompassIcons.notebook,
    selectedIcon: CompassIcons.notebookFilled,
  );
  static const skills = CompassBottomDestination(
    label: 'Skills',
    icon: CompassIcons.skills,
    selectedIcon: CompassIcons.skillsFilled,
  );
  static const progress = CompassBottomDestination(
    label: 'Progress',
    icon: CompassIcons.progress,
    selectedIcon: CompassIcons.progressFilled,
  );

  static const primary = [home, practice, notebook, skills, progress];
}

class CompassFab extends StatelessWidget {
  const CompassFab({
    super.key,
    required this.onPressed,
    this.icon = CompassIcons.add,
    this.tooltip = 'Create',
    this.mini = false,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final String tooltip;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    return CompassPressable(
      enabled: onPressed != null,
      child: mini
          ? FloatingActionButton.small(
              onPressed: onPressed,
              tooltip: tooltip,
              child: Icon(icon),
            )
          : FloatingActionButton(
              onPressed: onPressed,
              tooltip: tooltip,
              child: Icon(icon),
            ),
    );
  }
}

class CompassAvatar extends StatelessWidget {
  const CompassAvatar({
    super.key,
    this.image,
    this.initials,
    this.size = 40,
    this.onTap,
  });

  final ImageProvider? image;
  final String? initials;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final raw = initials?.trim() ?? '';
    final label = raw.isEmpty
        ? '?'
        : raw.substring(0, raw.length >= 2 ? 2 : 1).toUpperCase();

    final avatar = CircleAvatar(
      radius: size / 2,
      backgroundColor: scheme.primaryContainer,
      foregroundColor: scheme.onPrimaryContainer,
      backgroundImage: image,
      child: image == null
          ? Text(
              label,
              style: text.labelLarge?.copyWith(
                fontSize: size * 0.32,
                color: scheme.onPrimaryContainer,
              ),
            )
          : null,
    );

    return Semantics(
      button: onTap != null,
      label: 'Avatar',
      child: onTap == null
          ? avatar
          : InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: avatar,
            ),
    );
  }
}

enum CompassBadgeTone { neutral, brand, success, warning, danger }

class CompassBadge extends StatelessWidget {
  const CompassBadge({
    super.key,
    required this.label,
    this.tone = CompassBadgeTone.neutral,
  });

  final String label;
  final CompassBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final semantic = CompassSemanticColors.of(context);
    final text = Theme.of(context).textTheme;

    final Color background;
    final Color foreground;
    switch (tone) {
      case CompassBadgeTone.neutral:
        background = scheme.surfaceContainerHighest;
        foreground = scheme.onSurfaceVariant;
      case CompassBadgeTone.brand:
        background = scheme.primaryContainer;
        foreground = scheme.onPrimaryContainer;
      case CompassBadgeTone.success:
        background = semantic.successContainer;
        foreground = semantic.success;
      case CompassBadgeTone.warning:
        background = semantic.warningContainer;
        foreground = semantic.warning;
      case CompassBadgeTone.danger:
        background = semantic.dangerContainer;
        foreground = semantic.danger;
    }

    return Semantics(
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: CompassSpacing.sm,
          vertical: CompassSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(CompassRadii.sm),
        ),
        child: Text(
          label,
          style: text.labelSmall?.copyWith(color: foreground),
        ),
      ),
    );
  }
}
