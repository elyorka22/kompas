import 'package:flutter/material.dart';
import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/design_system/foundation/compass_atmosphere.dart';
import 'package:kompas/design_system/icons/compass_mark.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

class CompassSectionHeader extends StatelessWidget {
  const CompassSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });

  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: text.headlineMedium),
              if (subtitle != null) ...[
                const SizedBox(height: CompassSpacing.xs),
                Text(subtitle!, style: text.bodyMedium),
              ],
            ],
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}

class CompassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CompassAppBar({
    super.key,
    this.title,
    this.showBrand = false,
    this.actions,
    this.leading,
    this.centerTitle = false,
  });

  final String? title;
  final bool showBrand;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      centerTitle: centerTitle,
      title: showBrand
          ? const Row(
              children: [
                CompassMark(size: 28),
                SizedBox(width: CompassSpacing.sm),
                Text(AppConstants.appName),
              ],
            )
          : title == null
              ? null
              : Text(title!),
      actions: actions,
    );
  }
}

class CompassScaffold extends StatelessWidget {
  const CompassScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.showBrandInAppBar = false,
    this.bottomNavigationBar,
    this.leading,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showBrandInAppBar;
  final Widget? bottomNavigationBar;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final showAppBar = title != null || showBrandInAppBar;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: showAppBar
          ? CompassAppBar(
              title: title,
              showBrand: showBrandInAppBar,
              actions: actions,
              leading: leading,
            )
          : null,
      body: CompassAtmosphere(
        child: SafeArea(child: body),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
