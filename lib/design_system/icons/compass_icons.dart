import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_icon_sizes.dart';

/// Curated Material icons for Compass — single source, no ad-hoc icon choices.
abstract final class CompassIcons {
  static const IconData home = Icons.home_outlined;
  static const IconData homeFilled = Icons.home_rounded;
  static const IconData practice = Icons.mic_none_rounded;
  static const IconData practiceFilled = Icons.mic_rounded;
  static const IconData notebook = Icons.menu_book_outlined;
  static const IconData notebookFilled = Icons.menu_book_rounded;
  static const IconData skills = Icons.account_tree_outlined;
  static const IconData skillsFilled = Icons.account_tree_rounded;
  static const IconData progress = Icons.insights_outlined;
  static const IconData progressFilled = Icons.insights_rounded;
  static const IconData settings = Icons.settings_outlined;
  static const IconData search = Icons.search_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData back = Icons.arrow_back_rounded;
  static const IconData add = Icons.add_rounded;
  static const IconData check = Icons.check_rounded;
  static const IconData chevronRight = Icons.chevron_right_rounded;
  static const IconData streak = Icons.local_fire_department_outlined;
  static const IconData mission = Icons.flag_outlined;
  static const IconData profile = Icons.person_outline_rounded;
  static const IconData edit = Icons.edit_outlined;
  static const IconData more = Icons.more_horiz_rounded;

  static Icon icon(
    IconData data, {
    double size = CompassIconSizes.md,
    Color? color,
    String? semanticLabel,
  }) {
    return Icon(data, size: size, color: color, semanticLabel: semanticLabel);
  }
}
