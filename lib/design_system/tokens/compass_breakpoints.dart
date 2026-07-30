import 'package:flutter/material.dart';

/// Layout breakpoints for adaptive / responsive shells.
abstract final class CompassBreakpoints {
  static const double compact = 600;
  static const double medium = 840;
  static const double expanded = 1200;

  /// Comfortable reading / content column width.
  static const double contentMaxWidth = 720;
  static const double wideContentMaxWidth = 1080;

  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < compact;

  static bool isMedium(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= compact && width < expanded;
  }

  static bool isExpanded(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= expanded;
}
