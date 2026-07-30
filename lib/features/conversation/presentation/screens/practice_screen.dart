import 'package:flutter/material.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/presentation/shell/app_shell.dart';
import 'package:kompas/services/compass/practice_mode_catalog.dart';

/// Shell practice list — UI implementation is deferred.
class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return ListView(
      children: [
        const ShellHeader(
          title: 'Practice',
          subtitle: 'Guided by Compass Engine — offline in 0.1',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CompassSpacing.screenHorizontal,
          ),
          child: Column(
            children: PracticeMode.values
                .map(
                  (mode) => Padding(
                    padding: const EdgeInsets.only(bottom: CompassSpacing.sm),
                    child: CompassCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              PracticeModeCatalog.title(mode),
                              style: text.titleMedium,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
