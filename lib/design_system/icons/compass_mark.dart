import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';

/// Brand mark: a minimal compass rose used as visual identity.
class CompassMark extends StatelessWidget {
  const CompassMark({
    super.key,
    this.size = 40,
    this.color,
    this.needleColor,
  });

  final double size;
  final Color? color;
  final Color? needleColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CustomPaint(
      size: Size.square(size),
      painter: _CompassMarkPainter(
        ringColor: color ??
            (isDark ? CompassColors.compassBright : CompassColors.compass),
        needleColor: needleColor ?? CompassColors.needle,
      ),
    );
  }
}

class _CompassMarkPainter extends CustomPainter {
  _CompassMarkPainter({
    required this.ringColor,
    required this.needleColor,
  });

  final Color ringColor;
  final Color needleColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final ring = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08;

    canvas.drawCircle(center, radius * 0.82, ring);

    final tick = Paint()
      ..color = ringColor.withOpacity(0.7)
      ..strokeWidth = size.width * 0.045
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 4; i++) {
      final angle = (math.pi / 2) * i - math.pi / 2;
      final outer = Offset(
        center.dx + math.cos(angle) * radius * 0.72,
        center.dy + math.sin(angle) * radius * 0.72,
      );
      final inner = Offset(
        center.dx + math.cos(angle) * radius * 0.56,
        center.dy + math.sin(angle) * radius * 0.56,
      );
      canvas.drawLine(inner, outer, tick);
    }

    final needle = Path()
      ..moveTo(center.dx, center.dy - radius * 0.55)
      ..lineTo(center.dx + radius * 0.12, center.dy + radius * 0.08)
      ..lineTo(center.dx, center.dy + radius * 0.02)
      ..lineTo(center.dx - radius * 0.12, center.dy + radius * 0.08)
      ..close();

    canvas.drawPath(needle, Paint()..color = needleColor);
    canvas.drawCircle(
      center,
      radius * 0.08,
      Paint()..color = ringColor,
    );
  }

  @override
  bool shouldRepaint(covariant _CompassMarkPainter oldDelegate) {
    return oldDelegate.ringColor != ringColor ||
        oldDelegate.needleColor != needleColor;
  }
}
