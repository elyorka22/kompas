import 'package:flutter/material.dart';
import 'package:kompas/core/constants/animation_constants.dart';

/// Shared curves and durations — intentional motion, not decoration noise.
abstract final class CompassMotion {
  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
  static const Curve springy = Curves.easeOutBack;

  static const Duration instant = AnimationConstants.instant;
  static const Duration fast = AnimationConstants.fast;
  static const Duration normal = AnimationConstants.normal;
  static const Duration slow = AnimationConstants.slow;
  static const Duration page = AnimationConstants.page;
  static const Duration compassSpin = Duration(milliseconds: 900);
  static const Duration progress = Duration(milliseconds: 640);

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

  static Widget fadeScaleIn({
    required Animation<double> animation,
    required Widget child,
    double beginScale = 0.96,
  }) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: beginScale, end: 1).animate(
          CurvedAnimation(parent: animation, curve: standard),
        ),
        child: child,
      ),
    );
  }
}
