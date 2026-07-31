/// Visual feedback while [VoiceInputService] is listening.
library;

import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

class ListeningIndicator extends StatefulWidget {
  const ListeningIndicator({
    super.key,
    required this.listening,
    this.label = 'Listening…',
  });

  final bool listening;
  final String label;

  @override
  State<ListeningIndicator> createState() => _ListeningIndicatorState();
}

class _ListeningIndicatorState extends State<ListeningIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    if (widget.listening) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant ListeningIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listening && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.listening && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final phase = (_controller.value + index * 0.15) % 1.0;
                final height = 10.0 + (phase < 0.5 ? phase : 1 - phase) * 28;
                return Container(
                  width: 5,
                  height: widget.listening ? height : 10,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: scheme.primary.withOpacity(
                      widget.listening ? 0.85 : 0.35,
                    ),
                    borderRadius: BorderRadius.circular(CompassRadii.pill),
                  ),
                );
              }),
            );
          },
        ),
        const SizedBox(height: CompassSpacing.sm),
        Text(
          widget.label,
          style: text.labelLarge?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
