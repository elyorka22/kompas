import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kompas/core/providers/use_case_providers.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/domain/entities/conversation_message.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/personal_learning_profile.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/features/ai_adapter/domain/usecases/send_coach_turn.dart';
import 'package:kompas/features/coach_engine/domain/usecases/recommend_conversation_goal.dart';
import 'package:kompas/features/compass_engine/domain/usecases/start_session.dart';
import 'package:kompas/features/conversation/providers/session_providers.dart';
import 'package:kompas/features/daily_goals/providers/dashboard_providers.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/navigation/app_routes.dart';
import 'package:kompas/providers/voice_provider.dart';
import 'package:kompas/shared/catalog/russian_topic_catalog.dart';
import 'package:kompas/widgets/voice_input_button.dart';

/// Heart of Compass — AI Russian conversation coach.
class CoachChatScreen extends ConsumerStatefulWidget {
  const CoachChatScreen({super.key});

  @override
  ConsumerState<CoachChatScreen> createState() => _CoachChatScreenState();
}

class _CoachChatScreenState extends ConsumerState<CoachChatScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  ConversationSession? _session;
  bool _sending = false;
  bool _starting = false;
  String? _topic;
  String? _error;

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  String _greeting(KompasL10n l10n, String name) {
    final hour = DateTime.now().hour;
    if (name.isEmpty) return l10n.welcomeBack;
    if (hour < 12) return l10n.goodMorningName(name);
    if (hour < 18) return l10n.goodAfternoonName(name);
    return l10n.goodEveningName(name);
  }

  Future<void> _ensureSession({String? topic}) async {
    if (_session != null || _starting) return;
    final user = await ref.read(activeUserProvider.future);
    if (user == null || !mounted) return;
    setState(() {
      _starting = true;
      _error = null;
      _topic = topic ?? _topic;
    });

    final strategy = await ref.read(learningStrategyProvider.future);
    await ref.read(coachRecommendConversationGoalProvider)(
      RecommendConversationGoalParams(userId: user.id),
    );

    // Use StartSession with Russian conversation focus.
    final result = await ref.read(startSessionProvider)(
      StartSessionParams(
        userId: user.id,
        mode: PracticeMode.tellAboutDay,
        title: 'Разговор с коучем',
        prompt: topic ??
            strategy?.suggestedTopic ??
            'Сегодня потренируем разговорный русский.',
      ),
    );

    if (!mounted) return;
    result.fold(
      onSuccess: (session) {
        setState(() {
          _session = session;
          _starting = false;
        });
        ref.invalidate(sessionMessagesProvider(session.id));
      },
      onFailure: (failure) {
        setState(() {
          _starting = false;
          _error = failure.message;
        });
      },
    );
  }
  Future<void> _send([String? preset]) async {
    final text = (preset ?? _input.text).trim();
    if (text.isEmpty || _sending) return;

    await _ensureSession(topic: _topic);
    final session = _session;
    final user = await ref.read(activeUserProvider.future);
    if (session == null || user == null || !mounted) return;

    setState(() {
      _sending = true;
      _error = null;
    });
    _input.clear();

    final profile = PersonalLearningProfile(
      id: 'profile_${user.id}',
      userId: user.id,
      displayName: user.displayName,
      nativeLanguage: user.nativeLanguage,
      targetLanguage: AppLanguage.ru,
      updatedAt: DateTime.now().toUtc(),
    );

    final result = await ref.read(sendCoachTurnProvider)(
      SendCoachTurnParams(
        userId: user.id,
        session: session,
        profile: profile,
        userText: text,
        topic: _topic,
      ),
    );

    if (!mounted) return;
    result.fold(
      onSuccess: (_) {
        ref.invalidate(sessionMessagesProvider(session.id));
        setState(() => _sending = false);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scroll.hasClients) {
            _scroll.animateTo(
              _scroll.position.maxScrollExtent + 80,
              duration: CompassMotion.normal,
              curve: CompassMotion.standard,
            );
          }
        });
      },
      onFailure: (failure) {
        setState(() {
          _sending = false;
          _error = failure.message;
        });
        CompassSnackbars.show(context, message: failure.message);
      },
    );
  }

  Future<void> _startTopic(String topic) async {
    setState(() => _topic = topic);
    await _ensureSession(topic: topic);
    await _send(topic);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(activeUserProvider);
    final strategy = ref.watch(learningStrategyProvider);
    final insights = ref.watch(memoryInsightsProvider);
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final name = user.maybeWhen(
      data: (value) => value?.displayName ?? '',
      orElse: () => '',
    );

    final goalText = strategy.maybeWhen(
      data: (value) {
        if (value == null) return l10n.todayRussianFocus;
        if (value.expressionsToPractice.isNotEmpty) {
          return l10n.goalUseExpressions(
            value.expressionsToPractice.take(2).join(', '),
          );
        }
        if (value.reasons.isNotEmpty) return value.reasons.first.message;
        return l10n.todayRussianFocus;
      },
      orElse: () => l10n.todayRussianFocus,
    );

    final memoryHint = insights.maybeWhen(
      data: (lines) => lines.isEmpty ? null : lines.first,
      orElse: () => null,
    );

    final messages = _session == null
        ? const AsyncValue<List<ConversationMessage>>.data([])
        : ref.watch(sessionMessagesProvider(_session!.id));

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              CompassSpacing.screenHorizontal,
              CompassSpacing.md,
              CompassSpacing.screenHorizontal,
              0,
            ),
            child: Row(
              children: [
                const CompassWidget(size: 32),
                const SizedBox(width: CompassSpacing.sm),
                Expanded(
                  child: Text(l10n.appName, style: text.titleLarge),
                ),
                IconButton(
                  tooltip: l10n.settings,
                  onPressed: () => context.push(AppRoutes.settings),
                  icon: const Icon(CompassIcons.settings),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              controller: _scroll,
              padding: const EdgeInsets.all(CompassSpacing.screenHorizontal),
              children: [
                const SizedBox(height: CompassSpacing.lg),
                CompassAppear(
                  child: Text(
                    _greeting(l10n, name),
                    style: text.displaySmall,
                  ),
                ),
                const SizedBox(height: CompassSpacing.md),
                Text(
                  l10n.todayTrainSpokenRussian,
                  style: text.titleLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                if (memoryHint != null) ...[
                  const SizedBox(height: CompassSpacing.md),
                  Text(
                    memoryHint,
                    style: text.bodyLarge?.copyWith(
                      color: scheme.primary,
                      height: 1.45,
                    ),
                  ),
                ],
                const SizedBox(height: CompassSpacing.xl),
                Text(
                  l10n.todaysGoal,
                  style: text.labelLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: CompassSpacing.sm),
                Text(goalText, style: text.headlineSmall),
                const SizedBox(height: CompassSpacing.xl),
                messages.when(
                  data: (items) {
                    final chat = items
                        .where((m) => m.role != MessageRole.system)
                        .toList();
                    if (chat.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      children: [
                        for (final message in chat)
                          _Bubble(
                            isCoach: message.role == MessageRole.coach,
                            text: message.content,
                          ),
                        if (_sending)
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: CompassSpacing.md,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                l10n.coachTyping,
                                style: text.bodySmall,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (e, _) => Text('$e'),
                ),
                if (_session == null) ...[
                  Text(
                    l10n.suggestedTopics,
                    style: text.labelLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: CompassSpacing.md),
                  Wrap(
                    spacing: CompassSpacing.sm,
                    runSpacing: CompassSpacing.sm,
                    children: [
                      for (final topic in RussianTopicCatalog.topics)
                        ActionChip(
                          label: Text(topic),
                          onPressed: _starting ? null : () => _startTopic(topic),
                        ),
                    ],
                  ),
                  const SizedBox(height: CompassSpacing.lg),
                  Text(
                    l10n.quickSuggestions,
                    style: text.labelLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: CompassSpacing.md),
                  for (final tip in RussianTopicCatalog.quickSuggestions)
                    CompassSoftRow(
                      title: tip,
                      onTap: _starting ? null : () => _send(tip),
                    ),
                ],
                if (_error != null) ...[
                  const SizedBox(height: CompassSpacing.md),
                  Text(
                    _error!,
                    style: text.bodyMedium?.copyWith(color: scheme.error),
                  ),
                ],
                const SizedBox(height: CompassSpacing.xxl),
              ],
            ),
          ),
          _ComposerBar(
            controller: _input,
            sending: _sending || _starting,
            onSend: () => _send(),
            onVoiceStopped: (text) {
              final autoSend = ref.read(voiceAutoSendProvider);
              if (autoSend && text.trim().isNotEmpty) {
                _send(text);
              }
            },
            hint: l10n.chatHint,
            voiceLabel: l10n.voiceInput,
            attachLabel: l10n.attachSoon,
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.isCoach, required this.text});

  final bool isCoach;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.bodyLarge;
    return Align(
      alignment: isCoach ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: CompassSpacing.md),
        padding: const EdgeInsets.symmetric(
          horizontal: CompassSpacing.lg,
          vertical: CompassSpacing.md,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.82,
        ),
        decoration: BoxDecoration(
          color: isCoach
              ? scheme.surface.withOpacity(0.9)
              : scheme.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(CompassRadii.lg),
          border: Border.all(
            color: scheme.outline.withOpacity(0.25),
          ),
        ),
        child: Text(text, style: style?.copyWith(height: 1.45)),
      ),
    );
  }
}

class _ComposerBar extends StatelessWidget {
  const _ComposerBar({
    required this.controller,
    required this.sending,
    required this.onSend,
    required this.onVoiceStopped,
    required this.hint,
    required this.voiceLabel,
    required this.attachLabel,
  });

  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;
  final ValueChanged<String> onVoiceStopped;
  final String hint;
  final String voiceLabel;
  final String attachLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface.withOpacity(0.92),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            CompassSpacing.md,
            CompassSpacing.sm,
            CompassSpacing.md,
            CompassSpacing.sm,
          ),
          child: Row(
            children: [
              IconButton(
                tooltip: attachLabel,
                onPressed: () {
                  CompassSnackbars.show(context, message: attachLabel);
                },
                icon: const Icon(Icons.add_circle_outline_rounded),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  enabled: !sending,
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CompassRadii.lg),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: CompassSpacing.md,
                      vertical: CompassSpacing.sm,
                    ),
                  ),
                ),
              ),
              VoiceInputButton(
                controller: controller,
                enabled: !sending,
                tooltip: voiceLabel,
                onTextUpdated: (_) {},
                onListeningStopped: onVoiceStopped,
              ),
              CompassPressable(
                enabled: !sending,
                child: IconButton.filled(
                  onPressed: sending ? null : onSend,
                  icon: sending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.arrow_upward_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
