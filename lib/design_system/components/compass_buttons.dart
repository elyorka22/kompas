import 'package:flutter/material.dart';
import 'package:kompas/design_system/motion/compass_interactions.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

enum CompassButtonSize { regular, compact }

class CompassPrimaryButton extends StatelessWidget {
  const CompassPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expanded = true,
    this.size = CompassButtonSize.regular,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expanded;
  final CompassButtonSize size;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final height = size == CompassButtonSize.compact ? 44.0 : 52.0;
    final enabled = onPressed != null;
    final radius = BorderRadius.circular(CompassRadii.md);

    final labelChild = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: CompassSpacing.xs),
              Text(label),
            ],
          );

    final button = CompassPressable(
      enabled: enabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: radius,
          child: Ink(
            height: height,
            decoration: BoxDecoration(
              borderRadius: radius,
              gradient: enabled
                  ? LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: isDark
                          ? const [
                              CompassColors.compassBright,
                              Color(0xFF3DB8E8),
                              Color(0xFFFF7A55),
                            ]
                          : const [
                              CompassColors.compass,
                              Color(0xFF1AABB8),
                              CompassColors.needle,
                            ],
                    )
                  : null,
              color: enabled
                  ? null
                  : Theme.of(context).colorScheme.outline.withOpacity(0.35),
              boxShadow: enabled
                  ? [
                      BoxShadow(
                        color: CompassColors.compass.withOpacity(0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: DefaultTextStyle.merge(
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: enabled
                          ? (isDark ? CompassColors.ink : CompassColors.white)
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.4),
                      fontWeight: FontWeight.w600,
                    ),
                child: IconTheme.merge(
                  data: IconThemeData(
                    color: enabled
                        ? (isDark ? CompassColors.ink : CompassColors.white)
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.4),
                  ),
                  child: labelChild,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      label: label,
      enabled: enabled,
      child: expanded ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}

class CompassSecondaryButton extends StatelessWidget {
  const CompassSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final child = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: CompassSpacing.xs),
              Text(label),
            ],
          );

    final button = CompassPressable(
      enabled: onPressed != null,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: scheme.primary.withOpacity(0.55),
            width: 1.4,
          ),
          foregroundColor: scheme.primary,
        ),
        child: child,
      ),
    );

    return Semantics(
      button: true,
      label: label,
      enabled: onPressed != null,
      child: expanded ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}

class CompassGhostButton extends StatelessWidget {
  const CompassGhostButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final child = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: CompassSpacing.xs),
              Text(label),
            ],
          );

    return Semantics(
      button: true,
      label: label,
      enabled: onPressed != null,
      child: CompassPressable(
        enabled: onPressed != null,
        child: TextButton(
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
