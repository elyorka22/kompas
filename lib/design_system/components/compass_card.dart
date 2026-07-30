import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

/// Rounded interaction surface. Used only where interaction needs a container.
class CompassCard extends StatelessWidget {
  const CompassCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(CompassSpacing.lg),
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CompassRadii.lg),
        side: BorderSide(color: scheme.outline.withOpacity(0.7)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(CompassRadii.lg),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
