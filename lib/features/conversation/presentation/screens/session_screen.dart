import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/core/providers/core_providers.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/entities/conversation_message.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/features/compass_engine/domain/usecases/complete_exercise.dart';
import 'package:kompas/features/compass_engine/domain/usecases/finish_session.dart';
import 'package:kompas/features/conversation/providers/session_providers.dart';
import 'package:kompas/features/daily_goals/providers/daily_goals_providers.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/features/progress/providers/progress_providers.dart';
import 'package:kompas/features/skill_tree/providers/skill_tree_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/widgets/voice_input_button.dart';
import 'package:kompas/navigation/app_routes.dart';
import 'package:kompas/services/compass/skill_xp_rules.dart';

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  final _noteController = TextEditingController();
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _running = false;
  bool _finishing = false;

  @override
  void dispose() {
    _timer?.cancel();
    _noteController.dispose();
    super.dispose();
  }

  void _toggleTimer() {
    if (_running) {
      _timer?.cancel();
      setState(() => _running = false);
      return;
    }
    setState(() => _running = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _elapsedSeconds += 1);
    });
  }

  Future<void> _finish() async {
    final session =
        await ref.read(sessionByIdProvider(widget.sessionId).future);
    if (session == null || !mounted) return;

    setState(() => _finishing = true);
    _timer?.cancel();

    final note = _noteController.text.trim();
    if (note.isNotEmpty) {
      await ref.read(conversationRepositoryProvider).addMessage(
            ConversationMessage(
              id: IdGenerator.v4(),
              sessionId: session.id,
              role: MessageRole.user,
              content: note,
              createdAt: DateTime.now().toUtc(),
            ),
          );
      await ref.read(memoryEngineServiceProvider).rememberPracticePhrase(
            userId: session.userId,
            targetText: note,
            contextExample: session.prompt,
            tags: [session.mode.name],
          );
    }

    if (session.currentExerciseId != null) {
      await ref.read(completeExerciseProvider)(
        CompleteExerciseParams(
          userId: session.userId,
          exerciseId: session.currentExerciseId!,
          sessionId: session.id,
        ),
      );
    }

    final speakingSeconds =
        _elapsedSeconds > 0 ? _elapsedSeconds : 60; // minimum credit

    final result = await ref.read(finishSessionProvider)(
      FinishSessionParams(
        session: session,
        speakingSeconds: speakingSeconds,
      ),
    );

    if (!mounted) return;
    result.fold(
      onSuccess: (finished) {
        ref.read(lastFinishedSessionProvider.notifier).state = finished;
        ref.invalidate(todaysMissionsProvider);
        ref.invalidate(dailyCompletionProvider);
        ref.invalidate(userStatisticsProvider);
        ref.invalidate(skillTreeProvider);
        ref.invalidate(skillProgressViewsProvider);
        ref.invalidate(recentSessionsProvider);
        ref.invalidate(memoryInsightsProvider);
        ref.invalidate(recommendedExerciseProvider);
        ref.invalidate(learningStrategyProvider);
        context.go(AppRoutes.sessionCompletePath(finished.session.id));
      },
      onFailure: (failure) {
        setState(() => _finishing = false);
        CompassSnackbars.show(context, message: failure.message);
      },
    );
  }

  String _format(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final sessionAsync = ref.watch(sessionByIdProvider(widget.sessionId));
    final messagesAsync = ref.watch(sessionMessagesProvider(widget.sessionId));
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;

    return sessionAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
      error: (error, _) => Scaffold(body: Center(child: Text('$error'))),
      data: (session) {
        if (session == null) {
          return Scaffold(
            appBar: const CompassAppBar(title: 'Session'),
            body: Center(child: Text(l10n.sessionNotFound)),
          );
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CompassAppBar(
            title: session.title,
            leading: IconButton(
              icon: const Icon(CompassIcons.back),
              onPressed: () => context.pop(),
            ),
          ),
          body: CompassAtmosphere(
            child: CompassConversationTemplate(
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.practiceModeTitle(session.mode.name),
                    style: text.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: CompassSpacing.xs),
                  Text(
                    l10n.sessionEarnXp(SkillXpRules.sessionFinishXp),
                    style: text.bodySmall,
                  ),
                ],
              ),
              stage: ListView(
                children: [
                  CompassAppear(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.coachPrompt,
                          style: text.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: CompassSpacing.md),
                        Text(
                          session.prompt ?? '',
                          style: text.headlineMedium?.copyWith(height: 1.35),
                        ),
                        const SizedBox(height: CompassSpacing.xxl),
                        Center(
                          child: CompassPulse(
                            child: CompassProgressRing(
                              value: (_elapsedSeconds / 120).clamp(0.0, 1.0),
                              size: 140,
                              strokeWidth: 8,
                              child: Text(
                                _format(_elapsedSeconds),
                                style: text.headlineSmall,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: CompassSpacing.lg),
                        Center(
                          child: Text(
                            _running ? l10n.speakNow : l10n.startTimerHint,
                            textAlign: TextAlign.center,
                            style: text.bodyLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: CompassSpacing.xl),
                  messagesAsync.when(
                    data: (messages) {
                      final coach = messages
                          .where((m) => m.role == MessageRole.coach)
                          .toList();
                      if (coach.isEmpty) return const SizedBox.shrink();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.sessionNotes,
                            style: text.labelLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: CompassSpacing.sm),
                          for (final message in coach)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: CompassSpacing.sm,
                              ),
                              child: Text(
                                message.content,
                                style: text.bodyLarge,
                              ),
                            ),
                        ],
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: CompassSpacing.lg),
                  Text(
                    l10n.capturePhrase,
                    style: text.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: CompassSpacing.sm),
                  CompassInput(
                    controller: _noteController,
                    hint: l10n.capturePhraseHint,
                    maxLines: 3,
                    suffixIcon: VoiceInputButton(controller: _noteController),
                  ),
                ],
              ),
              composer: Column(
                children: [
                  CompassSecondaryButton(
                    label: _running ? l10n.pauseTimer : l10n.startSpeakingTimer,
                    icon:
                        _running ? Icons.pause_rounded : CompassIcons.practice,
                    onPressed: _finishing ? null : _toggleTimer,
                  ),
                  const SizedBox(height: CompassSpacing.sm),
                  CompassPrimaryButton(
                    label: _finishing ? l10n.saving : l10n.finishSession,
                    onPressed: _finishing ? null : _finish,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
