import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_semantic_colors.dart';

/// Elevation tokens — soft, premium shadows (not heavy Material blobs).
abstract final class CompassElevation {
  static const double none = 0;
  static const double low = 1;
  static const double medium = 4;
  static const double high = 8;
  static const double overlay = 16;

  static List<BoxShadow> soft(BuildContext context, {double level = low}) {
    final shadow = CompassSemanticColors.of(context).shadow;
    if (level <= 0) return const [];
    if (level <= low) {
      return [
        BoxShadow(
          color: shadow,
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
    }
    if (level <= medium) {
      return [
        BoxShadow(
          color: shadow,
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];
    }
    return [
      BoxShadow(
        color: shadow,
        blurRadius: 40,
        offset: const Offset(0, 16),
      ),
    ];
  }
}
