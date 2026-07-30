import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_semantic_colors.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/design_system/tokens/compass_typography.dart';

/// Material 3 theme factory for Compass Design System v1.
abstract final class CompassTheme {
  static ThemeData light() => _build(
        brightness: Brightness.light,
        scheme: const ColorScheme.light(
          primary: CompassColors.compass,
          onPrimary: CompassColors.white,
          primaryContainer: CompassColors.compassSoft,
          onPrimaryContainer: CompassColors.compassDeep,
          secondary: CompassColors.needle,
          onSecondary: CompassColors.white,
          secondaryContainer: CompassColors.needleSoft,
          onSecondaryContainer: CompassColors.ink,
          tertiary: CompassColors.aurora,
          onTertiary: CompassColors.white,
          tertiaryContainer: CompassColors.auroraSoft,
          onTertiaryContainer: CompassColors.ink,
          surface: CompassColors.snow,
          onSurface: CompassColors.ink,
          onSurfaceVariant: CompassColors.slate,
          surfaceContainerHighest: CompassColors.porcelain,
          error: CompassColors.danger,
          onError: CompassColors.white,
          outline: CompassColors.line,
          outlineVariant: Color(0xFFE6EBEF),
          shadow: Color(0x1A111418),
        ),
        scaffold: CompassColors.porcelain,
        semantic: CompassSemanticColors.light,
      );

  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        scheme: const ColorScheme.dark(
          primary: CompassColors.compassBright,
          onPrimary: CompassColors.ink,
          primaryContainer: Color(0xFF163838),
          onPrimaryContainer: CompassColors.compassSoft,
          secondary: CompassColors.needle,
          onSecondary: CompassColors.white,
          secondaryContainer: Color(0xFF3A221C),
          onSecondaryContainer: CompassColors.needleSoft,
          tertiary: CompassColors.aurora,
          onTertiary: CompassColors.ink,
          tertiaryContainer: Color(0xFF16324A),
          onTertiaryContainer: CompassColors.auroraSoft,
          surface: CompassColors.darkCard,
          onSurface: CompassColors.darkText,
          onSurfaceVariant: CompassColors.darkMuted,
          surfaceContainerHighest: CompassColors.darkElevated,
          error: Color(0xFFE06A5C),
          onError: CompassColors.ink,
          outline: CompassColors.darkLine,
          outlineVariant: Color(0xFF222830),
          shadow: Color(0x66000000),
        ),
        scaffold: CompassColors.darkSurface,
        semantic: CompassSemanticColors.dark,
      );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme scheme,
    required Color scaffold,
    required CompassSemanticColors semantic,
  }) {
    final text = CompassTypography.textTheme(brightness);
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      textTheme: text,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.headlineSmall,
        foregroundColor: scheme.onSurface,
        iconTheme: IconThemeData(color: scheme.onSurface, size: 24),
      ),
      cardTheme: CardTheme(
        color: scheme.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CompassRadii.lg),
          side: BorderSide(color: scheme.outline.withOpacity(0.85)),
        ),
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.outline.withOpacity(0.35),
          disabledForegroundColor: scheme.onSurface.withOpacity(0.4),
          minimumSize: const Size(CompassSpacing.touchTarget, 52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CompassRadii.md),
          ),
          textStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          elevation: 0,
          shadowColor: scheme.primary.withOpacity(0.4),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          minimumSize: const Size(CompassSpacing.touchTarget, 52),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          side: BorderSide(color: scheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CompassRadii.md),
          ),
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(CompassSpacing.touchTarget, 44),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          textStyle: text.labelLarge,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 2,
        focusElevation: 3,
        hoverElevation: 3,
        highlightElevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CompassRadii.lg),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
          borderSide: BorderSide(color: scheme.primary, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
          borderSide: BorderSide(color: scheme.error),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 74,
        elevation: 0,
        backgroundColor: isDark ? CompassColors.darkCard : CompassColors.snow,
        indicatorColor: isDark
            ? CompassColors.compassBright.withOpacity(0.22)
            : CompassColors.compassSoft,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return text.labelSmall?.copyWith(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? scheme.primary : scheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 24,
            color: selected ? scheme.primary : scheme.onSurfaceVariant,
          );
        }),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(CompassRadii.xl),
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CompassRadii.xl),
        ),
        titleTextStyle: text.headlineSmall,
        contentTextStyle: text.bodyMedium,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? CompassColors.darkElevated : CompassColors.ink,
        contentTextStyle: text.bodyMedium?.copyWith(
          color: isDark ? CompassColors.darkText : CompassColors.snow,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CompassRadii.md),
        ),
        elevation: 2,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        selectedColor: scheme.primaryContainer,
        labelStyle: text.labelMedium!,
        side: BorderSide(color: scheme.outline.withOpacity(0.6)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CompassRadii.sm),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outline.withOpacity(0.7),
        thickness: 1,
        space: 1,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.outline.withOpacity(0.35),
        circularTrackColor: scheme.outline.withOpacity(0.35),
      ),
      dividerColor: scheme.outline,
      splashFactory: InkSparkle.splashFactory,
    ).copyWith(
      extensions: <ThemeExtension<dynamic>>[semantic],
    );
  }
}
