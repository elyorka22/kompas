import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

/// Soft abstract illustrations — atmosphere, not cartoon mascots.
enum CompassIllustrationKind {
  orbit,
  horizon,
  constellation,
  path,
}

class CompassIllustration extends StatelessWidget {
  const CompassIllustration({
    super.key,
    this.kind = CompassIllustrationKind.orbit,
    this.height = 160,
    this.semanticLabel = 'Illustration',
  });

  final CompassIllustrationKind kind;
  final double height;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Semantics(
      label: semanticLabel,
      image: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CompassRadii.lg),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: CustomPaint(
            painter: _IllustrationPainter(
              kind: kind,
              primary: isDark
                  ? CompassColors.compassBright
                  : CompassColors.compass,
              accent: CompassColors.needle,
              wash: isDark
                  ? CompassColors.darkElevated
                  : CompassColors.auroraSoft.withOpacity(0.45),
              ink: isDark ? CompassColors.darkLine : CompassColors.line,
            ),
          ),
        ),
      ),
    );
  }
}

class _IllustrationPainter extends CustomPainter {
  _IllustrationPainter({
    required this.kind,
    required this.primary,
    required this.accent,
    required this.wash,
    required this.ink,
  });

  final CompassIllustrationKind kind;
  final Color primary;
  final Color accent;
  final Color wash;
  final Color ink;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = wash);

    switch (kind) {
      case CompassIllustrationKind.orbit:
        _paintOrbit(canvas, size);
      case CompassIllustrationKind.horizon:
        _paintHorizon(canvas, size);
      case CompassIllustrationKind.constellation:
        _paintConstellation(canvas, size);
      case CompassIllustrationKind.path:
        _paintPath(canvas, size);
    }
  }

  void _paintOrbit(Canvas canvas, Size size) {
    final c = Offset(size.width * 0.55, size.height * 0.48);
    for (var i = 1; i <= 3; i++) {
      canvas.drawCircle(
        c,
        size.shortestSide * (0.16 * i),
        Paint()
          ..color = primary.withOpacity(0.18 + i * 0.08)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6,
      );
    }
    canvas.drawCircle(
      Offset(size.width * 0.28, size.height * 0.3),
      22,
      Paint()..color = CompassColors.aurora.withOpacity(0.28),
    );
    canvas.drawCircle(c, 7, Paint()..color = accent);
  }

  void _paintHorizon(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.62)
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 0.42,
        size.width * 0.7,
        size.height * 0.58,
      )
      ..quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.66,
        size.width,
        size.height * 0.55,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = primary.withOpacity(0.22));
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.28),
      18,
      Paint()..color = accent.withOpacity(0.85),
    );
  }

  void _paintConstellation(Canvas canvas, Size size) {
    final points = [
      Offset(size.width * 0.2, size.height * 0.55),
      Offset(size.width * 0.38, size.height * 0.32),
      Offset(size.width * 0.58, size.height * 0.4),
      Offset(size.width * 0.74, size.height * 0.28),
      Offset(size.width * 0.82, size.height * 0.58),
    ];
    final line = Paint()
      ..color = primary.withOpacity(0.45)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    for (var i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], line);
    }
    for (final p in points) {
      canvas.drawCircle(p, 4, Paint()..color = primary);
    }
    canvas.drawCircle(points[2], 6, Paint()..color = accent);
  }

  void _paintPath(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(CompassSpacing.lg, size.height * 0.7)
      ..cubicTo(
        size.width * 0.3,
        size.height * 0.2,
        size.width * 0.55,
        size.height * 0.85,
        size.width - CompassSpacing.lg,
        size.height * 0.35,
      );
    canvas.drawPath(
      path,
      Paint()
        ..color = primary.withOpacity(0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..strokeCap = StrokeCap.round,
    );
    final tip = Offset(size.width - CompassSpacing.lg, size.height * 0.35);
    canvas.drawCircle(tip, 7, Paint()..color = accent);
    canvas.drawArc(
      Rect.fromCircle(center: tip, radius: 16),
      -math.pi / 2,
      math.pi,
      false,
      Paint()
        ..color = accent.withOpacity(0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(covariant _IllustrationPainter oldDelegate) {
    return oldDelegate.kind != kind ||
        oldDelegate.primary != primary ||
        oldDelegate.accent != accent ||
        oldDelegate.wash != wash;
  }
}
