import 'package:flutter/material.dart';
import 'package:kompas/design_system/components/compass_card.dart';
import 'package:kompas/design_system/tokens/compass_spacing.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/presentation/shell/app_shell.dart';

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
            children: SessionMode.values
                .map(
                  (mode) => Padding(
                    padding: const EdgeInsets.only(bottom: CompassSpacing.sm),
                    child: CompassCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _label(mode),
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

  String _label(SessionMode mode) {
    return switch (mode) {
      SessionMode.freeTalk => 'Free talk',
      SessionMode.storytelling => 'Storytelling',
      SessionMode.argumentation => 'Argumentation',
      SessionMode.explanation => 'Explanation',
      SessionMode.speakingDrill => 'Speaking drill',
      SessionMode.memoryReview => 'Memory review',
    };
  }
}
