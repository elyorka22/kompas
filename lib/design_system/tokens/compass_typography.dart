import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';

/// Large, calm typography — Manrope (premium product, not schoolbook).
abstract final class CompassTypography {
  static TextTheme textTheme(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? CompassColors.darkText
        : CompassColors.ink;
    final muted = brightness == Brightness.dark
        ? CompassColors.darkMuted
        : CompassColors.slate;

    final display = GoogleFonts.manrope(
      color: base,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.2,
      height: 1.05,
    );
    final body = GoogleFonts.manrope(
      color: base,
      fontWeight: FontWeight.w400,
      height: 1.45,
    );

    return TextTheme(
      displayLarge: display.copyWith(fontSize: 48),
      displayMedium: display.copyWith(fontSize: 40),
      displaySmall: display.copyWith(fontSize: 34),
      headlineLarge: display.copyWith(fontSize: 28, letterSpacing: -0.8),
      headlineMedium: display.copyWith(fontSize: 24, letterSpacing: -0.6),
      headlineSmall: display.copyWith(fontSize: 20, letterSpacing: -0.4),
      titleLarge: body.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      titleMedium: body.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: body.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: body.copyWith(fontSize: 17),
      bodyMedium: body.copyWith(fontSize: 15),
      bodySmall: body.copyWith(fontSize: 13, color: muted),
      labelLarge: body.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: body.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
      labelSmall:
          body.copyWith(fontSize: 11, fontWeight: FontWeight.w500, color: muted),
    );
  }
}
