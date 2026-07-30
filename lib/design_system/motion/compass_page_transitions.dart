import 'package:flutter/material.dart';
import 'package:kompas/design_system/motion/compass_motion.dart';

/// Premium page route transitions for GoRouter / Navigator.
abstract final class CompassPageTransitions {
  static Page<T> fadeSlide<T>({
    required LocalKey key,
    required Widget child,
    String? name,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      name: name,
      child: child,
      transitionDuration: CompassMotion.page,
      reverseTransitionDuration: CompassMotion.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return CompassMotion.fadeSlideIn(animation: animation, child: child);
      },
    );
  }

  static Page<T> fadeScale<T>({
    required LocalKey key,
    required Widget child,
    String? name,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      name: name,
      child: child,
      transitionDuration: CompassMotion.page,
      reverseTransitionDuration: CompassMotion.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return CompassMotion.fadeScaleIn(animation: animation, child: child);
      },
    );
  }
}

/// Lightweight custom page used by [CompassPageTransitions].
class CustomTransitionPage<T> extends Page<T> {
  const CustomTransitionPage({
    required this.child,
    required this.transitionsBuilder,
    this.transitionDuration = CompassMotion.page,
    this.reverseTransitionDuration = CompassMotion.normal,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final Duration transitionDuration;
  final Duration reverseTransitionDuration;
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) transitionsBuilder;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: transitionsBuilder,
    );
  }
}
