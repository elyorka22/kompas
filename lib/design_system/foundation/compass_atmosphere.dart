import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:kompas/design_system/motion/compass_motion.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';

/// Soft moving aurora behind screens — premium atmosphere, not flat gray.
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
      duration: const Duration(seconds: 12),
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
                  begin: Alignment(-0.8 + t * 0.3, -1),
                  end: Alignment(1, 1.1 - t * 0.2),
                  colors: isDark
                      ? [
                          CompassColors.darkSurface,
                          Color.lerp(
                            const Color(0xFF0A2A2C),
                            const Color(0xFF12283A),
                            t,
                          )!,
                          CompassColors.darkSurface,
                        ]
                      : [
                          CompassColors.porcelain,
                          Color.lerp(
                            CompassColors.compassSoft,
                            CompassColors.auroraSoft,
                            t,
                          )!,
                          const Color(0xFFFFF7F3),
                        ],
                ),
              ),
            ),
            Positioned(
              top: -80 + 30 * t,
              right: -40,
              child: _GlowOrb(
                size: 220 * widget.intensity,
                color: (isDark
                        ? CompassColors.compassBright
                        : CompassColors.compass)
                    .withOpacity(isDark ? 0.22 : 0.28),
              ),
            ),
            Positioned(
              bottom: 80,
              left: -60 + 20 * (1 - t),
              child: _GlowOrb(
                size: 180 * widget.intensity,
                color: CompassColors.needle.withOpacity(isDark ? 0.16 : 0.18),
              ),
            ),
            Positioned(
              top: 220,
              left: 40 + 40 * t,
              child: _GlowOrb(
                size: 120 * widget.intensity,
                color: CompassColors.aurora.withOpacity(isDark ? 0.14 : 0.2),
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

/// Gradient hero surface for dashboard / celebration moments.
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [
                  Color(0xFF0F4D4A),
                  Color(0xFF163A55),
                  Color(0xFF4A2A22),
                ]
              : const [
                  Color(0xFF0E9A96),
                  Color(0xFF1FB8C9),
                  Color(0xFFFF7A4D),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? CompassColors.compassBright : CompassColors.compass)
                .withOpacity(0.35),
            blurRadius: 28,
            offset: const Offset(0, 14),
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

/// Accent strip used on cards for visual rhythm.
class CompassAccentBar extends StatelessWidget {
  const CompassAccentBar({
    super.key,
    this.colors = const [
      CompassColors.compassBright,
      CompassColors.aurora,
      CompassColors.needle,
    ],
  });

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        gradient: LinearGradient(colors: colors),
      ),
    );
  }
}

/// Subtle shimmer pulse for loading / live states.
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
      duration: const Duration(milliseconds: 1600),
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
        final scale = 1 + (_controller.value * 0.025);
        return Transform.scale(scale: scale, child: child);
      },
      child: widget.child,
    );
  }
}

double compassWave(double t) => (math.sin(t * math.pi * 2) + 1) / 2;
