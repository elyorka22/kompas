import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kompas/design_system/motion/compass_interactions.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';
import 'package:kompas/design_system/tokens/compass_elevation.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_semantic_colors.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

enum CompassCardVariant { plain, elevated, glass, accent }

/// Rounded interaction surface. Prefer only when a container aids interaction.
class CompassCard extends StatelessWidget {
  const CompassCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(CompassSpacing.lg),
    this.variant = CompassCardVariant.plain,
    this.semanticLabel,
  });

  const CompassCard.glass({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(CompassSpacing.lg),
    this.semanticLabel,
  }) : variant = CompassCardVariant.glass;

  const CompassCard.elevated({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(CompassSpacing.lg),
    this.semanticLabel,
  }) : variant = CompassCardVariant.elevated;

  const CompassCard.accent({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(CompassSpacing.lg),
    this.semanticLabel,
  }) : variant = CompassCardVariant.accent;

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final CompassCardVariant variant;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final semantic = CompassSemanticColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(CompassRadii.lg);

    final content = Padding(padding: padding, child: child);

    late final Widget body;
    switch (variant) {
      case CompassCardVariant.glass:
        body = ClipRRect(
          borderRadius: radius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: semantic.glassFill,
                borderRadius: radius,
                border: Border.all(color: semantic.glassBorder),
              ),
              child: content,
            ),
          ),
        );
      case CompassCardVariant.elevated:
        body = DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: radius,
            border: Border.all(color: scheme.outline.withOpacity(0.25)),
            boxShadow: CompassElevation.soft(
              context,
              level: CompassElevation.medium,
            ),
          ),
          child: content,
        );
      case CompassCardVariant.accent:
        body = DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: radius,
            border: Border.all(
              color: (isDark
                      ? CompassColors.compassBright
                      : CompassColors.compass)
                  .withOpacity(0.35),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      scheme.surface,
                      CompassColors.compassDeep.withOpacity(0.35),
                    ]
                  : [
                      scheme.surface,
                      CompassColors.compassSoft.withOpacity(0.65),
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: CompassColors.compass.withOpacity(isDark ? 0.2 : 0.12),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: content,
        );
      case CompassCardVariant.plain:
        body = DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: radius,
            border: Border.all(color: scheme.outline.withOpacity(0.55)),
          ),
          child: content,
        );
    }

    final interactive = onTap == null
        ? body
        : CompassPressable(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: radius,
                child: body,
              ),
            ),
          );

    return Semantics(
      button: onTap != null,
      label: semanticLabel,
      child: interactive,
    );
  }
}

/// Frosted glass surface (explicit alias of [CompassCard.glass]).
class CompassGlassCard extends StatelessWidget {
  const CompassGlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(CompassSpacing.lg),
    this.semanticLabel,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return CompassCard.glass(
      onTap: onTap,
      padding: padding,
      semanticLabel: semanticLabel,
      child: child,
    );
  }
}
