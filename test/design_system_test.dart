import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kompas/design_system/design_system.dart';

Widget wrap(Widget child, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme ?? CompassTheme.light(),
    home: Scaffold(body: child),
  );
}

void main() {
  test('semantic color tokens differ by brightness', () {
    expect(
      CompassSemanticColors.light.mutedForeground,
      CompassColors.slate,
    );
    expect(
      CompassSemanticColors.dark.mutedForeground,
      CompassColors.darkMuted,
    );
  });

  testWidgets('theme registers semantic extension', (tester) async {
    late ThemeData theme;

    await tester.pumpWidget(
      MaterialApp(
        theme: CompassTheme.dark(),
        home: Builder(
          builder: (context) {
            theme = Theme.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(theme.brightness, Brightness.dark);
    final semantic = theme.extension<CompassSemanticColors>();
    expect(semantic, isNotNull);
    expect(semantic!.mutedForeground, CompassColors.darkMuted);
    expect(CompassSemanticColors.of(
      tester.element(find.byType(SizedBox)),
    ).brandSoft, isNot(CompassSemanticColors.light.brandSoft));
  });

  testWidgets('core components render without exceptions', (tester) async {
    await tester.pumpWidget(
      wrap(
        SingleChildScrollView(
          child: Column(
            children: [
              const CompassMark(size: 32),
              const CompassWidget(size: 64, animate: false),
              CompassPrimaryButton(label: 'Primary', onPressed: () {}),
              CompassSecondaryButton(label: 'Secondary', onPressed: () {}),
              CompassGhostButton(label: 'Ghost', onPressed: () {}),
              const CompassCard(child: Text('Card')),
              const CompassGlassCard(child: Text('Glass')),
              const CompassProgressRing(value: 0.4),
              const CompassProgressBar(value: 0.6),
              const CompassSkillCard(
                title: 'Speaking',
                subtitle: 'Core',
                progress: 0.5,
              ),
              const CompassStatisticCard(label: 'Streak', value: '4'),
              const CompassExerciseCard(
                title: 'Explain',
                subtitle: 'Word practice',
              ),
              const CompassMissionCard(
                title: 'Mission',
                subtitle: 'Speak 2 minutes',
                progress: 0.25,
              ),
              const CompassSectionHeader(title: 'Section'),
              const CompassAvatar(initials: 'AK'),
              const CompassBadge(label: 'New', tone: CompassBadgeTone.brand),
              const CompassIllustration(kind: CompassIllustrationKind.orbit),
              CompassBottomNavigation(
                destinations: CompassNavDestinations.primary,
                selectedIndex: 0,
                onDestinationSelected: (_) {},
              ),
              CompassFab(onPressed: () {}),
              const CompassInput(hint: 'Name'),
              const CompassSearchField(),
            ],
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.text('Primary'), findsOneWidget);
    expect(find.text('Card'), findsOneWidget);
    expect(find.text('Speaking'), findsOneWidget);
  });

  testWidgets('page templates compose slots', (tester) async {
    await tester.pumpWidget(
      wrap(
        const CompassDashboardTemplate(
          header: CompassSectionHeader(title: 'Kompas'),
          hero: CompassCard(child: Text('Hero')),
          missions: CompassMissionCard(
            title: 'Daily',
            subtitle: 'Ready',
            progress: 0,
          ),
        ),
      ),
    );
    expect(find.text('Hero'), findsOneWidget);
    expect(find.text('Daily'), findsOneWidget);
  });
}
