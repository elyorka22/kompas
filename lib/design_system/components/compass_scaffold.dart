import 'package:flutter/material.dart';
import 'package:kompas/core/constants/app_constants.dart';
import 'package:kompas/design_system/icons/compass_mark.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';

class CompassScaffold extends StatelessWidget {
  const CompassScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.showBrandInAppBar = false,
    this.bottomNavigationBar,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showBrandInAppBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null && !showBrandInAppBar
          ? null
          : AppBar(
              title: showBrandInAppBar
                  ? const Row(
                      children: [
                        CompassMark(size: 28),
                        SizedBox(width: CompassSpacing.sm),
                        Text(AppConstants.appName),
                      ],
                    )
                  : Text(title!),
              actions: actions,
            ),
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
