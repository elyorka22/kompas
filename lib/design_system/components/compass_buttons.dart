import 'package:flutter/material.dart';
import 'package:kompas/design_system/motion/compass_interactions.dart';
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
      child: FilledButton(
        onPressed: onPressed,
        style: size == CompassButtonSize.compact
            ? FilledButton.styleFrom(
                minimumSize: const Size(CompassSpacing.touchTarget, 44),
              )
            : null,
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
