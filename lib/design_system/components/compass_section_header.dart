import 'package:flutter/material.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

class CompassSectionHeader extends StatelessWidget {
  const CompassSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: text.headlineMedium),
        if (subtitle != null) ...[
          const SizedBox(height: CompassSpacing.xs),
          Text(subtitle!, style: text.bodyMedium),
        ],
      ],
    );
  }
}
