import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kompas/design_system/motion/compass_motion.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';

/// Brand mark: minimal compass rose.
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
    return Semantics(
      label: 'Kompas',
      image: true,
      child: CustomPaint(
        size: Size.square(size),
        painter: CompassMarkPainter(
          ringColor: color ??
              (isDark ? CompassColors.compassBright : CompassColors.compass),
          needleColor: needleColor ?? CompassColors.needle,
        ),
      ),
    );
  }
}

/// Animated compass rose — gentle needle rotation for presence.
class CompassWidget extends StatefulWidget {
  const CompassWidget({
    super.key,
    this.size = 96,
    this.animate = true,
    this.turns = 0.08,
  });

  final double size;
  final bool animate;

  /// Fractional turns applied as idle sway (e.g. 0.08 ≈ 29°).
  final double turns;

  @override
  State<CompassWidget> createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: CompassMotion.compassSpin,
    );
    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant CompassWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Semantics(
      label: 'Compass',
      image: true,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = widget.animate
              ? (_controller.value * 2 - 1) * widget.turns * math.pi
              : 0.0;
          return Transform.rotate(
            angle: angle,
            child: child,
          );
        },
        child: CustomPaint(
          size: Size.square(widget.size),
          painter: CompassMarkPainter(
            ringColor:
                isDark ? CompassColors.compassBright : CompassColors.compass,
            needleColor: CompassColors.needle,
            showTicks: true,
          ),
        ),
      ),
    );
  }
}

class CompassMarkPainter extends CustomPainter {
  CompassMarkPainter({
    required this.ringColor,
    required this.needleColor,
    this.showTicks = true,
  });

  final Color ringColor;
  final Color needleColor;
  final bool showTicks;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final ring = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08;

    canvas.drawCircle(center, radius * 0.82, ring);

    if (showTicks) {
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
  bool shouldRepaint(covariant CompassMarkPainter oldDelegate) {
    return oldDelegate.ringColor != ringColor ||
        oldDelegate.needleColor != needleColor ||
        oldDelegate.showTicks != showTicks;
  }
}
