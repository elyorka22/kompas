import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_breakpoints.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

/// Centers content and caps width on large screens.
class CompassResponsive extends StatelessWidget {
  const CompassResponsive({
    super.key,
    required this.child,
    this.maxWidth = CompassBreakpoints.contentMaxWidth,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: CompassSpacing.screenHorizontal,
              ),
          child: child,
        ),
      ),
    );
  }
}

/// Horizontal page gutters that grow slightly on wide layouts.
EdgeInsets compassScreenPadding(BuildContext context) {
  final wide = !CompassBreakpoints.isCompact(context);
  return EdgeInsets.fromLTRB(
    wide ? CompassSpacing.xl : CompassSpacing.screenHorizontal,
    CompassSpacing.screenTop,
    wide ? CompassSpacing.xl : CompassSpacing.screenHorizontal,
    CompassSpacing.lg,
  );
}
