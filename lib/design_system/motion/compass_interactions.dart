import 'package:flutter/material.dart';
import 'package:kompas/design_system/motion/compass_motion.dart';

/// Press scale micro-interaction shared by buttons and tappable surfaces.
class CompassPressable extends StatefulWidget {
  const CompassPressable({
    super.key,
    required this.child,
    this.enabled = true,
    this.pressedScale = 0.98,
  });

  final Widget child;
  final bool enabled;
  final double pressedScale;

  @override
  State<CompassPressable> createState() => _CompassPressableState();
}

class _CompassPressableState extends State<CompassPressable> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: widget.enabled && _pressed ? widget.pressedScale : 1,
      duration: CompassMotion.instant,
      curve: CompassMotion.standard,
      child: Listener(
        onPointerDown: widget.enabled
            ? (_) => setState(() => _pressed = true)
            : null,
        onPointerUp: (_) => setState(() => _pressed = false),
        onPointerCancel: (_) => setState(() => _pressed = false),
        child: widget.child,
      ),
    );
  }
}

/// Card / list item entrance animation.
class CompassAppear extends StatefulWidget {
  const CompassAppear({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 0.03),
  });

  final Widget child;
  final Duration delay;
  final Offset offset;

  @override
  State<CompassAppear> createState() => _CompassAppearState();
}

class _CompassAppearState extends State<CompassAppear>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: CompassMotion.normal,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: CompassMotion.enter,
    );
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompassMotion.fadeSlideIn(
      animation: _animation,
      begin: widget.offset,
      child: widget.child,
    );
  }
}

/// Smoothly animates a 0–1 progress value.
class CompassAnimatedProgress extends StatelessWidget {
  const CompassAnimatedProgress({
    super.key,
    required this.value,
    required this.builder,
    this.duration = CompassMotion.progress,
  });

  final double value;
  final Duration duration;
  final Widget Function(BuildContext context, double animatedValue) builder;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: value.clamp(0.0, 1.0)),
      duration: duration,
      curve: CompassMotion.emphasized,
      builder: (context, animatedValue, _) => builder(context, animatedValue),
    );
  }
}
