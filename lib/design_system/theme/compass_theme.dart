import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_typography.dart';

abstract final class CompassTheme {
  static ThemeData light() {
    final text = CompassTypography.textTheme(Brightness.light);
    const scheme = ColorScheme.light(
      primary: CompassColors.compass,
      onPrimary: Colors.white,
      secondary: CompassColors.needle,
      onSecondary: Colors.white,
      surface: CompassColors.snow,
      onSurface: CompassColors.ink,
      error: CompassColors.danger,
      outline: CompassColors.line,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: CompassColors.porcelain,
      textTheme: text,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.headlineSmall,
        foregroundColor: CompassColors.ink,
      ),
      cardTheme: CardTheme(
        color: CompassColors.snow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CompassRadii.lg),
          side: const BorderSide(color: CompassColors.line),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: CompassColors.compass,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CompassRadii.md),
          ),
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: CompassColors.ink,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: CompassColors.line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CompassRadii.md),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CompassColors.snow,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
          borderSide: const BorderSide(color: CompassColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
          borderSide: const BorderSide(color: CompassColors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
          borderSide: const BorderSide(color: CompassColors.compass, width: 1.4),
        ),
      ),
      dividerColor: CompassColors.line,
      splashFactory: InkSparkle.splashFactory,
    );
  }

  static ThemeData dark() {
    final text = CompassTypography.textTheme(Brightness.dark);
    const scheme = ColorScheme.dark(
      primary: CompassColors.compassBright,
      onPrimary: CompassColors.ink,
      secondary: CompassColors.needle,
      onSecondary: Colors.white,
      surface: CompassColors.darkCard,
      onSurface: CompassColors.darkText,
      error: CompassColors.danger,
      outline: CompassColors.darkLine,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: CompassColors.darkSurface,
      textTheme: text,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.headlineSmall,
        foregroundColor: CompassColors.darkText,
      ),
      cardTheme: CardTheme(
        color: CompassColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CompassRadii.lg),
          side: const BorderSide(color: CompassColors.darkLine),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: CompassColors.compassBright,
          foregroundColor: CompassColors.ink,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CompassRadii.md),
          ),
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: CompassColors.darkText,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: CompassColors.darkLine),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CompassRadii.md),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CompassColors.darkCard,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
          borderSide: const BorderSide(color: CompassColors.darkLine),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
          borderSide: const BorderSide(color: CompassColors.darkLine),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
          borderSide:
              const BorderSide(color: CompassColors.compassBright, width: 1.4),
        ),
      ),
      dividerColor: CompassColors.darkLine,
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
