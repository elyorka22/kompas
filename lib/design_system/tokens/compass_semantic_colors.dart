import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';

/// Semantic colors resolved per brightness via [ThemeExtension].
@immutable
class CompassSemanticColors extends ThemeExtension<CompassSemanticColors> {
  const CompassSemanticColors({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.danger,
    required this.onDanger,
    required this.dangerContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.mutedForeground,
    required this.subtleFill,
    required this.glassFill,
    required this.glassBorder,
    required this.brandSoft,
    required this.accentSoft,
    required this.shadow,
  });

  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color danger;
  final Color onDanger;
  final Color dangerContainer;
  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color mutedForeground;
  final Color subtleFill;
  final Color glassFill;
  final Color glassBorder;
  final Color brandSoft;
  final Color accentSoft;
  final Color shadow;

  static const light = CompassSemanticColors(
    success: CompassColors.success,
    onSuccess: CompassColors.white,
    successContainer: CompassColors.successSoft,
    warning: CompassColors.warning,
    onWarning: CompassColors.ink,
    warningContainer: CompassColors.warningSoft,
    danger: CompassColors.danger,
    onDanger: CompassColors.white,
    dangerContainer: CompassColors.dangerSoft,
    info: CompassColors.info,
    onInfo: CompassColors.white,
    infoContainer: CompassColors.infoSoft,
    mutedForeground: CompassColors.slate,
    subtleFill: CompassColors.porcelain,
    glassFill: CompassColors.lightGlass,
    glassBorder: Color(0x66D7DDE3),
    brandSoft: CompassColors.compassSoft,
    accentSoft: CompassColors.needleSoft,
    shadow: Color(0x1A111418),
  );

  static const dark = CompassSemanticColors(
    success: Color(0xFF3CB87A),
    onSuccess: CompassColors.ink,
    successContainer: Color(0xFF163528),
    warning: Color(0xFFE0A43A),
    onWarning: CompassColors.ink,
    warningContainer: Color(0xFF3A2E14),
    danger: Color(0xFFE06A5C),
    onDanger: CompassColors.ink,
    dangerContainer: Color(0xFF3A1C18),
    info: Color(0xFF6B93F5),
    onInfo: CompassColors.ink,
    infoContainer: Color(0xFF1A2748),
    mutedForeground: CompassColors.darkMuted,
    subtleFill: CompassColors.darkElevated,
    glassFill: CompassColors.darkGlass,
    glassBorder: Color(0x662A3138),
    brandSoft: Color(0xFF163838),
    accentSoft: Color(0xFF3A221C),
    shadow: Color(0x66000000),
  );

  static CompassSemanticColors of(BuildContext context) {
    return Theme.of(context).extension<CompassSemanticColors>() ??
        (Theme.of(context).brightness == Brightness.dark ? dark : light);
  }

  @override
  CompassSemanticColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? danger,
    Color? onDanger,
    Color? dangerContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? mutedForeground,
    Color? subtleFill,
    Color? glassFill,
    Color? glassBorder,
    Color? brandSoft,
    Color? accentSoft,
    Color? shadow,
  }) {
    return CompassSemanticColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      dangerContainer: dangerContainer ?? this.dangerContainer,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      subtleFill: subtleFill ?? this.subtleFill,
      glassFill: glassFill ?? this.glassFill,
      glassBorder: glassBorder ?? this.glassBorder,
      brandSoft: brandSoft ?? this.brandSoft,
      accentSoft: accentSoft ?? this.accentSoft,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  CompassSemanticColors lerp(
    ThemeExtension<CompassSemanticColors>? other,
    double t,
  ) {
    if (other is! CompassSemanticColors) return this;
    return CompassSemanticColors(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
      dangerContainer: Color.lerp(dangerContainer, other.dangerContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      subtleFill: Color.lerp(subtleFill, other.subtleFill, t)!,
      glassFill: Color.lerp(glassFill, other.glassFill, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      brandSoft: Color.lerp(brandSoft, other.brandSoft, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}
