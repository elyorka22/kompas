import 'package:flutter/material.dart';

/// Compass visual identity — teal needle on charcoal / porcelain.
///
/// Premium AI-product palette (Linear / Arc / Notion tone).
/// Avoids purple gradients and cream–terracotta clichés.
abstract final class CompassColors {
  // Neutrals — light
  static const Color ink = Color(0xFF111418);
  static const Color inkSoft = Color(0xFF1C2228);
  static const Color slate = Color(0xFF5B6570);
  static const Color mist = Color(0xFF8B95A1);
  static const Color line = Color(0xFFD7DDE3);
  static const Color porcelain = Color(0xFFF4F6F8);
  static const Color snow = Color(0xFFFBFCFD);
  static const Color white = Color(0xFFFFFFFF);

  // Brand
  static const Color compass = Color(0xFF0F7B7B);
  static const Color compassBright = Color(0xFF19A3A3);
  static const Color compassDeep = Color(0xFF0A5555);
  static const Color compassSoft = Color(0xFFD7EFEF);
  static const Color needle = Color(0xFFE4572E);
  static const Color needleSoft = Color(0xFFF8E4DE);

  // Semantic (raw)
  static const Color success = Color(0xFF1F8A5B);
  static const Color successSoft = Color(0xFFD9F0E5);
  static const Color warning = Color(0xFFC9851A);
  static const Color warningSoft = Color(0xFFF7ECD8);
  static const Color danger = Color(0xFFC44536);
  static const Color dangerSoft = Color(0xFFF6DDD9);
  static const Color info = Color(0xFF2F6FED);
  static const Color infoSoft = Color(0xFFDCE7FB);

  // Neutrals — dark
  static const Color darkSurface = Color(0xFF0E1216);
  static const Color darkCard = Color(0xFF171C22);
  static const Color darkElevated = Color(0xFF1E252C);
  static const Color darkLine = Color(0xFF2A3138);
  static const Color darkText = Color(0xFFE8EDF2);
  static const Color darkMuted = Color(0xFF9AA4AF);
  static const Color darkGlass = Color(0xCC171C22);
  static const Color lightGlass = Color(0xCCFBFCFD);
}
