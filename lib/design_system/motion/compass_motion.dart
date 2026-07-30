import 'package:flutter/material.dart';
import 'package:kompas/core/constants/animation_constants.dart';

/// Shared curves and durations for intentional motion (not decoration noise).
abstract final class CompassMotion {
  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubic;

  static const Duration fast = AnimationConstants.fast;
  static const Duration normal = AnimationConstants.normal;
  static const Duration page = AnimationConstants.page;

  static Widget fadeSlideIn({
    required Animation<double> animation,
    required Widget child,
    Offset begin = const Offset(0, 0.04),
  }) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
          CurvedAnimation(parent: animation, curve: standard),
        ),
        child: child,
      ),
    );
  }
}
