import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kompas/design_system/motion/compass_motion.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';

/// Soft moving wash behind screens — quiet premium atmosphere.
class CompassAtmosphere extends StatefulWidget {
  const CompassAtmosphere({
    super.key,
    required this.child,
    this.intensity = 1,
  });

  final Widget child;
  final double intensity;

  @override
  State<CompassAtmosphere> createState() => _CompassAtmosphereState();
}

class _CompassAtmosphereState extends State<CompassAtmosphere>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.6 + t * 0.2, -1),
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          CompassColors.darkSurface,
                          Color.lerp(
                            const Color(0xFF0A1C1E),
                            const Color(0xFF0F1A22),
                            t,
                          )!,
                          CompassColors.darkSurface,
                        ]
                      : [
                          const Color(0xFFF7FBFA),
                          Color.lerp(
                            const Color(0xFFEEF7F6),
                            const Color(0xFFF4F8FA),
                            t,
                          )!,
                          const Color(0xFFF9F7F5),
                        ],
                ),
              ),
            ),
            Positioned(
              top: -100 + 20 * t,
              right: -50,
              child: _GlowOrb(
                size: 260 * widget.intensity,
                color: (isDark
                        ? CompassColors.compassBright
                        : CompassColors.compass)
                    .withOpacity(isDark ? 0.12 : 0.14),
              ),
            ),
            Positioned(
              bottom: 40,
              left: -70,
              child: _GlowOrb(
                size: 200 * widget.intensity,
                color: CompassColors.needle.withOpacity(isDark ? 0.06 : 0.07),
              ),
            ),
            child!,
          ],
        );
      },
      child: widget.child,
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              color.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}

/// Soft mentor surface for rare celebration moments.
class CompassHeroPanel extends StatelessWidget {
  const CompassHeroPanel({
    super.key,
    required this.child,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(28);
    final panel = AnimatedContainer(
      duration: CompassMotion.normal,
      curve: CompassMotion.standard,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [
                  Color(0xFF0E3A38),
                  Color(0xFF143048),
                ]
              : const [
                  Color(0xFF0E8F8A),
                  Color(0xFF147A8F),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: CompassColors.compass.withOpacity(0.22),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: isDark ? CompassColors.darkText : CompassColors.white,
        ),
        child: IconTheme.merge(
          data: IconThemeData(
            color: isDark ? CompassColors.darkText : CompassColors.white,
          ),
          child: child,
        ),
      ),
    );

    if (onTap == null) return panel;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: panel,
      ),
    );
  }
}

/// Accent strip used sparingly for visual rhythm.
class CompassAccentBar extends StatelessWidget {
  const CompassAccentBar({
    super.key,
    this.colors = const [
      CompassColors.compassBright,
      CompassColors.compass,
    ],
  });

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        gradient: LinearGradient(colors: colors),
      ),
    );
  }
}

/// Subtle shimmer pulse for live states.
class CompassPulse extends StatefulWidget {
  const CompassPulse({super.key, required this.child});

  final Widget child;

  @override
  State<CompassPulse> createState() => _CompassPulseState();
}

class _CompassPulseState extends State<CompassPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 1 + (_controller.value * 0.02);
        return Transform.scale(scale: scale, child: child);
      },
      child: widget.child,
    );
  }
}

double compassWave(double t) => (math.sin(t * math.pi * 2) + 1) / 2;
