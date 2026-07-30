import 'package:flutter/material.dart';
import 'package:kompas/design_system/foundation/compass_responsive.dart';
import 'package:kompas/design_system/tokens/compass_breakpoints.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

/// Shared scrollable page chrome for templates.
class CompassPageTemplate extends StatelessWidget {
  const CompassPageTemplate({
    super.key,
    required this.children,
    this.header,
    this.footer,
    this.maxWidth = CompassBreakpoints.contentMaxWidth,
    this.physics,
  });

  final Widget? header;
  final List<Widget> children;
  final Widget? footer;
  final double maxWidth;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CompassResponsive(
        maxWidth: maxWidth,
        padding: EdgeInsets.zero,
        child: ListView(
          physics: physics,
          padding: compassScreenPadding(context),
          children: [
            if (header != null) ...[
              header!,
              const SizedBox(height: CompassSpacing.sectionGap),
            ],
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1)
                const SizedBox(height: CompassSpacing.sectionGap),
            ],
            if (footer != null) ...[
              const SizedBox(height: CompassSpacing.sectionGap),
              footer!,
            ],
            const SizedBox(height: CompassSpacing.xl),
          ],
        ),
      ),
    );
  }
}

/// Dashboard / Home layout — brand header, hero, missions, secondary modules.
class CompassDashboardTemplate extends StatelessWidget {
  const CompassDashboardTemplate({
    super.key,
    required this.header,
    required this.hero,
    this.missions,
    this.secondary,
    this.footer,
  });

  final Widget header;
  final Widget hero;
  final Widget? missions;
  final List<Widget>? secondary;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return CompassPageTemplate(
      header: header,
      footer: footer,
      children: [
        hero,
        if (missions != null) missions!,
        ...?secondary,
      ],
    );
  }
}

/// Conversation / practice session layout.
class CompassConversationTemplate extends StatelessWidget {
  const CompassConversationTemplate({
    super.key,
    required this.header,
    required this.stage,
    this.composer,
    this.sidebar,
  });

  final Widget header;
  final Widget stage;
  final Widget? composer;
  final Widget? sidebar;

  @override
  Widget build(BuildContext context) {
    final wide = CompassBreakpoints.isExpanded(context) && sidebar != null;
    final body = Column(
      children: [
        Padding(
          padding: compassScreenPadding(context).copyWith(bottom: 0),
          child: header,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: compassScreenPadding(context).left,
            ),
            child: stage,
          ),
        ),
        if (composer != null)
          Padding(
            padding: compassScreenPadding(context).copyWith(top: CompassSpacing.md),
            child: composer,
          ),
      ],
    );

    if (!wide) {
      return SafeArea(child: body);
    }

    return SafeArea(
      child: Row(
        children: [
          Expanded(flex: 3, child: body),
          const SizedBox(width: CompassSpacing.lg),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(CompassSpacing.lg),
              child: sidebar!,
            ),
          ),
        ],
      ),
    );
  }
}

class CompassNotebookTemplate extends StatelessWidget {
  const CompassNotebookTemplate({
    super.key,
    required this.header,
    required this.search,
    required this.list,
    this.empty,
  });

  final Widget header;
  final Widget search;
  final Widget list;
  final Widget? empty;

  @override
  Widget build(BuildContext context) {
    return CompassPageTemplate(
      header: header,
      children: [
        search,
        list,
        if (empty != null) empty!,
      ],
    );
  }
}

class CompassDailyMissionsTemplate extends StatelessWidget {
  const CompassDailyMissionsTemplate({
    super.key,
    required this.header,
    required this.summary,
    required this.missions,
    this.cta,
  });

  final Widget header;
  final Widget summary;
  final Widget missions;
  final Widget? cta;

  @override
  Widget build(BuildContext context) {
    return CompassPageTemplate(
      header: header,
      footer: cta,
      children: [summary, missions],
    );
  }
}

class CompassProfileTemplate extends StatelessWidget {
  const CompassProfileTemplate({
    super.key,
    required this.header,
    required this.identity,
    this.stats,
    this.sections = const [],
  });

  final Widget header;
  final Widget identity;
  final Widget? stats;
  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    return CompassPageTemplate(
      header: header,
      children: [
        identity,
        if (stats != null) stats!,
        ...sections,
      ],
    );
  }
}

class CompassProgressTemplate extends StatelessWidget {
  const CompassProgressTemplate({
    super.key,
    required this.header,
    required this.overview,
    this.charts,
    this.details,
  });

  final Widget header;
  final Widget overview;
  final Widget? charts;
  final Widget? details;

  @override
  Widget build(BuildContext context) {
    return CompassPageTemplate(
      maxWidth: CompassBreakpoints.wideContentMaxWidth,
      header: header,
      children: [
        overview,
        if (charts != null) charts!,
        if (details != null) details!,
      ],
    );
  }
}

class CompassSettingsTemplate extends StatelessWidget {
  const CompassSettingsTemplate({
    super.key,
    required this.header,
    required this.sections,
  });

  final Widget header;
  final List<Widget> sections;

  @override
  Widget build(BuildContext context) {
    return CompassPageTemplate(
      header: header,
      children: sections,
    );
  }
}

class CompassOnboardingTemplate extends StatelessWidget {
  const CompassOnboardingTemplate({
    super.key,
    required this.visual,
    required this.title,
    required this.body,
    required this.actions,
    this.stepIndicator,
  });

  final Widget visual;
  final Widget title;
  final Widget body;
  final Widget actions;
  final Widget? stepIndicator;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CompassResponsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: CompassSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (stepIndicator != null) ...[
                stepIndicator!,
                const SizedBox(height: CompassSpacing.lg),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    visual,
                    const SizedBox(height: CompassSpacing.xl),
                    title,
                    const SizedBox(height: CompassSpacing.md),
                    body,
                  ],
                ),
              ),
              actions,
            ],
          ),
        ),
      ),
    );
  }
}
