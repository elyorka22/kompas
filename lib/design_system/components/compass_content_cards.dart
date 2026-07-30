import 'package:flutter/material.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/components/compass_progress.dart';
import 'package:kompas/design_system/foundation/compass_atmosphere.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_semantic_colors.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

class CompassSkillCard extends StatelessWidget {
  const CompassSkillCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    this.leading,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final double progress;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final semantic = CompassSemanticColors.of(context);

    return CompassCard(
      onTap: onTap,
      semanticLabel: '$title skill',
      child: Row(
        children: [
          leading ??
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: semantic.brandSoft,
                  borderRadius: BorderRadius.circular(CompassRadii.sm),
                ),
                alignment: Alignment.center,
                child: Text(
                  title.isEmpty ? '?' : title.substring(0, 1).toUpperCase(),
                  style: text.titleMedium,
                ),
              ),
          const SizedBox(width: CompassSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: text.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: text.bodySmall),
                const SizedBox(height: CompassSpacing.sm),
                CompassProgressBar(value: progress, height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CompassStatisticCard extends StatelessWidget {
  const CompassStatisticCard({
    super.key,
    required this.label,
    required this.value,
    this.caption,
    this.icon,
    this.onTap,
  });

  final String label;
  final String value;
  final String? caption;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return CompassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(CompassSpacing.md),
      semanticLabel: '$label $value',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, color: scheme.primary, size: 22),
            const SizedBox(height: CompassSpacing.sm),
          ],
          Text(value, style: text.headlineSmall),
          const SizedBox(height: CompassSpacing.xxs),
          Text(label, style: text.labelMedium),
          if (caption != null) ...[
            const SizedBox(height: CompassSpacing.xxs),
            Text(caption!, style: text.bodySmall),
          ],
        ],
      ),
    );
  }
}

class CompassExerciseCard extends StatelessWidget {
  const CompassExerciseCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.meta,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String? meta;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return CompassCard.elevated(
      onTap: onTap,
      semanticLabel: title,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CompassColors.compassBright,
                  CompassColors.aurora,
                  CompassColors.needle,
                ],
              ),
            ),
          ),
          const SizedBox(width: CompassSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: text.titleMedium),
                const SizedBox(height: CompassSpacing.xxs),
                Text(subtitle, style: text.bodyMedium),
                if (meta != null) ...[
                  const SizedBox(height: CompassSpacing.xs),
                  Text(meta!, style: text.labelSmall),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: CompassSpacing.sm),
            trailing!,
          ],
        ],
      ),
    );
  }
}

class CompassMissionCard extends StatelessWidget {
  const CompassMissionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    this.completed = false,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final double progress;
  final bool completed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final semantic = CompassSemanticColors.of(context);

    return CompassCard.accent(
      onTap: onTap,
      semanticLabel: completed ? '$title completed' : title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CompassAccentBar(),
          const SizedBox(height: CompassSpacing.sm),
          Row(
            children: [
              Expanded(child: Text(title, style: text.titleMedium)),
              if (completed)
                Icon(Icons.check_circle_rounded, color: semantic.success),
            ],
          ),
          const SizedBox(height: CompassSpacing.xxs),
          Text(subtitle, style: text.bodyMedium),
          const SizedBox(height: CompassSpacing.md),
          CompassProgressBar(value: progress),
        ],
      ),
    );
  }
}
