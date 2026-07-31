import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kompas/design_system/motion/compass_interactions.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

/// Animated circular progress ring with teal → aurora → coral sweep.
class CompassProgressRing extends StatelessWidget {
  const CompassProgressRing({
    super.key,
    required this.value,
    this.size = 72,
    this.strokeWidth = 6,
    this.child,
    this.semanticLabel,
    this.onDark = false,
  });

  /// 0.0 – 1.0
  final double value;
  final double size;
  final double strokeWidth;
  final Widget? child;
  final String? semanticLabel;

  /// Use when ring sits on a vivid/dark hero surface.
  final bool onDark;

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
                trackColor: onDark
                    ? Colors.white.withOpacity(0.22)
                    : scheme.outline.withOpacity(0.35),
                strokeWidth: strokeWidth,
                gradientColors: onDark
                    ? const [
                        Color(0xFFFFFFFF),
                        Color(0xFFE8FFFB),
                      ]
                    : const [
                        CompassColors.compassBright,
                        CompassColors.compass,
                      ],
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
    required this.strokeWidth,
    required this.gradientColors,
  });

  final double progress;
  final Color trackColor;
  final double strokeWidth;
  final List<Color> gradientColors;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, track);

    if (progress <= 0) return;

    final fill = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: gradientColors,
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect);

    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fill,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

/// Animated linear progress bar with brand gradient fill.
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
                  Container(color: scheme.outline.withOpacity(0.28)),
                  FractionallySizedBox(
                    widthFactor: animated,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            CompassColors.compassBright,
                            CompassColors.compass,
                          ],
                        ),
                      ),
                    ),
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
