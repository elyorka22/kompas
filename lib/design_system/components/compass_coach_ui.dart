import 'package:flutter/material.dart';
import 'package:kompas/design_system/components/compass_buttons.dart';
import 'package:kompas/design_system/components/compass_progress.dart';
import 'package:kompas/design_system/motion/compass_interactions.dart';
import 'package:kompas/design_system/tokens/compass_colors.dart';
import 'package:kompas/design_system/tokens/compass_radii.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

/// Quiet page opening — large type, no chrome noise.
class CompassPageIntro extends StatelessWidget {
  const CompassPageIntro({
    super.key,
    required this.title,
    this.eyebrow,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (eyebrow != null) ...[
                Text(
                  eyebrow!,
                  style: text.labelMedium?.copyWith(
                    color: scheme.primary,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: CompassSpacing.sm),
              ],
              Text(title, style: text.displaySmall),
              if (subtitle != null) ...[
                const SizedBox(height: CompassSpacing.sm),
                Text(
                  subtitle!,
                  style: text.bodyLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// Soft borderless surface — depth without “card wall”.
class CompassQuietSurface extends StatelessWidget {
  const CompassQuietSurface({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(CompassSpacing.lg),
    this.emphasized = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(CompassRadii.xl);
    final fill = emphasized
        ? (isDark
            ? const Color(0xFF142226)
            : CompassColors.compassSoft.withOpacity(0.55))
        : (isDark
            ? CompassColors.darkCard.withOpacity(0.72)
            : Colors.white.withOpacity(0.72));

    final body = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: padding,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: radius,
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : Colors.black.withOpacity(0.04),
        ),
        boxShadow: emphasized
            ? [
                BoxShadow(
                  color: CompassColors.compass.withOpacity(isDark ? 0.18 : 0.1),
                  blurRadius: 32,
                  offset: const Offset(0, 16),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.25 : 0.04),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
      ),
      child: child,
    );

    if (onTap == null) return body;
    return CompassPressable(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: body,
        ),
      ),
    );
  }
}

/// Mentor recommendation — the emotional center of Home / Practice.
class CompassCoachRecommend extends StatelessWidget {
  const CompassCoachRecommend({
    super.key,
    required this.title,
    required this.reason,
    required this.actionLabel,
    required this.onAction,
    this.meta,
    this.leading,
  });

  final String title;
  final String reason;
  final String actionLabel;
  final VoidCallback onAction;
  final String? meta;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CompassAppear(
      child: CompassQuietSurface(
        emphasized: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                leading ??
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 18,
                      color: scheme.primary,
                    ),
                const SizedBox(width: CompassSpacing.xs),
                Text(
                  meta ?? 'Coach',
                  style: text.labelMedium?.copyWith(color: scheme.primary),
                ),
              ],
            ),
            const SizedBox(height: CompassSpacing.lg),
            Text(title, style: text.headlineMedium),
            const SizedBox(height: CompassSpacing.md),
            Text(
              reason,
              style: text.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: CompassSpacing.xl),
            CompassPrimaryButton(
              label: actionLabel,
              onPressed: onAction,
            ),
            if (!isDark) const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}

/// Narrative insight line — Progress storytelling unit.
class CompassInsightStory extends StatelessWidget {
  const CompassInsightStory({
    super.key,
    required this.story,
    this.emphasis = false,
  });

  final String story;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: CompassSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 3,
            height: emphasis ? 28 : 22,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: scheme.primary.withOpacity(emphasis ? 1 : 0.45),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: CompassSpacing.md),
          Expanded(
            child: Text(
              story,
              style: (emphasis ? text.headlineSmall : text.titleLarge)?.copyWith(
                height: 1.35,
                fontWeight: emphasis ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Practice mission — not a catalog row.
class CompassMissionExercise extends StatelessWidget {
  const CompassMissionExercise({
    super.key,
    required this.title,
    required this.difficulty,
    required this.durationLabel,
    required this.skillsLabel,
    required this.reason,
    required this.actionLabel,
    required this.onAction,
    this.featured = false,
  });

  final String title;
  final String difficulty;
  final String durationLabel;
  final String skillsLabel;
  final String reason;
  final String actionLabel;
  final VoidCallback onAction;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return CompassAppear(
      child: CompassQuietSurface(
        emphasized: featured,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: featured ? text.headlineSmall : text.titleLarge),
            const SizedBox(height: CompassSpacing.sm),
            Wrap(
              spacing: CompassSpacing.sm,
              runSpacing: CompassSpacing.xs,
              children: [
                _MetaChip(label: difficulty),
                _MetaChip(label: durationLabel),
                _MetaChip(label: skillsLabel),
              ],
            ),
            const SizedBox(height: CompassSpacing.md),
            Text(
              reason,
              style: text.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
            const SizedBox(height: CompassSpacing.lg),
            Align(
              alignment: Alignment.centerLeft,
              child: featured
                  ? CompassPrimaryButton(
                      label: actionLabel,
                      onPressed: onAction,
                      expanded: true,
                    )
                  : CompassSecondaryButton(
                      label: actionLabel,
                      onPressed: onAction,
                      expanded: false,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CompassSpacing.sm,
        vertical: CompassSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withOpacity(0.7),
        borderRadius: BorderRadius.circular(CompassRadii.sm),
      ),
      child: Text(label, style: text.labelSmall),
    );
  }
}

/// Quiet secondary row — mission / shortcut / achievement.
class CompassSoftRow extends StatelessWidget {
  const CompassSoftRow({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.leading,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return CompassPressable(
      enabled: onTap != null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(CompassRadii.lg),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: CompassSpacing.md),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: CompassSpacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: text.titleMedium),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: text.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing ??
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: scheme.onSurfaceVariant.withOpacity(0.6),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Skill node for living progression path.
class CompassSkillNode extends StatelessWidget {
  const CompassSkillNode({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.statusLabel,
    required this.state,
    this.showConnector = true,
  });

  final String title;
  final String subtitle;
  final double progress;
  final String statusLabel;
  final CompassSkillNodeState state;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final muted = state == CompassSkillNodeState.locked;
    final mastered = state == CompassSkillNodeState.mastered;

    return Column(
      children: [
        Opacity(
          opacity: muted ? 0.45 : 1,
          child: CompassQuietSurface(
            emphasized: state == CompassSkillNodeState.growing,
            padding: const EdgeInsets.all(CompassSpacing.lg),
            child: Row(
              children: [
                _SkillOrb(state: state, progress: progress),
                const SizedBox(width: CompassSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: text.titleLarge),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: text.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      if (!muted) ...[
                        const SizedBox(height: CompassSpacing.sm),
                        CompassProgressBar(value: progress, height: 5),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: CompassSpacing.sm),
                Text(
                  statusLabel,
                  style: text.labelSmall?.copyWith(
                    color: mastered ? scheme.primary : scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showConnector)
          Container(
            width: 2,
            height: 22,
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  scheme.primary.withOpacity(mastered || !muted ? 0.45 : 0.12),
                  scheme.primary.withOpacity(0.08),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

enum CompassSkillNodeState { locked, growing, mastered, available }

class _SkillOrb extends StatelessWidget {
  const _SkillOrb({required this.state, required this.progress});

  final CompassSkillNodeState state;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (state) {
      CompassSkillNodeState.mastered => scheme.primary,
      CompassSkillNodeState.growing => CompassColors.needle,
      CompassSkillNodeState.available => scheme.primary.withOpacity(0.7),
      CompassSkillNodeState.locked => scheme.outline,
    };

    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (state == CompassSkillNodeState.growing ||
              state == CompassSkillNodeState.mastered)
            CompassProgressRing(
              value: progress.clamp(0.05, 1),
              size: 44,
              strokeWidth: 3,
            )
          else
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.5), width: 2),
              ),
            ),
          Icon(
            switch (state) {
              CompassSkillNodeState.mastered => Icons.check_rounded,
              CompassSkillNodeState.locked => Icons.lock_outline_rounded,
              CompassSkillNodeState.growing => Icons.trending_up_rounded,
              CompassSkillNodeState.available => Icons.circle_outlined,
            },
            size: 16,
            color: color,
          ),
        ],
      ),
    );
  }
}

/// Thin section label with generous top spacing.
class CompassQuietSection extends StatelessWidget {
  const CompassQuietSection({
    super.key,
    required this.label,
    required this.child,
    this.action,
  });

  final String label;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: CompassSpacing.xl),
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: text.labelLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            if (action != null) action!,
          ],
        ),
        const SizedBox(height: CompassSpacing.md),
        child,
      ],
    );
  }
}
