import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kompas/design_system/motion/compass_interactions.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

/// Animated circular progress ring.
class CompassProgressRing extends StatelessWidget {
  const CompassProgressRing({
    super.key,
    required this.value,
    this.size = 72,
    this.strokeWidth = 6,
    this.child,
    this.semanticLabel,
  });

  /// 0.0 – 1.0
  final double value;
  final double size;
  final double strokeWidth;
  final Widget? child;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: semanticLabel ?? 'Progress ${(value * 100).round()} percent',
      value: '${(value * 100).round()}%',
      child: CompassAnimatedProgress(
        value: value,
        builder: (context, animated) {
          return SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: _RingPainter(
                progress: animated,
                trackColor: scheme.outline.withOpacity(0.35),
                progressColor: scheme.primary,
                strokeWidth: strokeWidth,
              ),
              child: Center(child: child),
            ),
          );
        },
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    final fill = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, track);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fill,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.trackColor != trackColor;
  }
}

/// Animated linear progress bar.
class CompassProgressBar extends StatelessWidget {
  const CompassProgressBar({
    super.key,
    required this.value,
    this.height = 8,
    this.semanticLabel,
  });

  final double value;
  final double height;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: semanticLabel ?? 'Progress',
      value: '${(value * 100).round()}%',
      child: CompassAnimatedProgress(
        value: value,
        builder: (context, animated) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(CompassRadii.pill),
            child: SizedBox(
              height: height,
              child: Stack(
                children: [
                  Container(color: scheme.outline.withOpacity(0.3)),
                  FractionallySizedBox(
                    widthFactor: animated,
                    child: Container(color: scheme.primary),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Compact labeled progress row used inside cards.
class CompassProgressRow extends StatelessWidget {
  const CompassProgressRow({
    super.key,
    required this.label,
    required this.value,
    this.trailing,
  });

  final String label;
  final double value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: text.labelLarge)),
            trailing ??
                Text(
                  '${(value * 100).round()}%',
                  style: text.labelMedium,
                ),
          ],
        ),
        const SizedBox(height: CompassSpacing.xs),
        CompassProgressBar(value: value),
      ],
    );
  }
}
