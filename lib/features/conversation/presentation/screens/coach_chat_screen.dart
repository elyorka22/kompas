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
import 'package:kompas/features/compass_engine/domain/usecases/start_session.dart';
import 'package:kompas/features/conversation/providers/session_providers.dart';
import 'package:kompas/features/profile/providers/profile_providers.dart';
import 'package:kompas/features/notebook/providers/notebook_providers.dart';
import 'package:kompas/l10n/kompas_l10n.dart';
import 'package:kompas/navigation/app_routes.dart';
import 'package:kompas/providers/voice_provider.dart';
import 'package:kompas/widgets/voice_input_button.dart';

/// Simple AI Russian conversation coach — chat first.
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
  String? _error;

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _ensureSession() async {
    if (_session != null || _starting) return;
    final user = await ref.read(activeUserProvider.future);
    if (user == null || !mounted) return;
    setState(() {
      _starting = true;
      _error = null;
    });

    final result = await ref.read(startSessionProvider)(
      StartSessionParams(
        userId: user.id,
        mode: PracticeMode.tellAboutDay,
        title: 'Разговор с коучем',
        prompt: 'Сегодня потренируем разговорный русский.',
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

    await _ensureSession();
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
      ),
    );

    if (!mounted) return;
    result.fold(
      onSuccess: (turn) {
        ref.invalidate(sessionMessagesProvider(session.id));
        if (turn.savedNotebookWords.isNotEmpty) {
          ref.invalidate(notebookItemsProvider);
        }
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

  @override
  Widget build(BuildContext context) {
    final l10n = KompasL10n.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

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
              CompassSpacing.sm,
              CompassSpacing.sm,
            ),
            child: Row(
              children: [
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
            child: messages.when(
              data: (items) {
                final chat = items
                    .where((m) => m.role != MessageRole.system)
                    .toList();
                if (chat.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        CompassSpacing.screenHorizontal,
                      ),
                      child: Text(
                        l10n.todayTrainSpokenRussian,
                        textAlign: TextAlign.center,
                        style: text.titleMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ),
                  );
                }
                return ListView(
                  controller: _scroll,
                  padding: const EdgeInsets.all(
                    CompassSpacing.screenHorizontal,
                  ),
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
                        child: Text(
                          l10n.coachTyping,
                          style: text.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    if (_error != null)
                      Text(
                        _error!,
                        style: text.bodyMedium?.copyWith(color: scheme.error),
                      ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
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
              ? scheme.surfaceContainerHighest.withOpacity(0.65)
              : scheme.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(CompassRadii.lg),
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
  });

  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;
  final ValueChanged<String> onVoiceStopped;
  final String hint;
  final String voiceLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surface,
      elevation: 0,
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  enabled: !sending,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    fillColor: scheme.surfaceContainerHighest.withOpacity(0.55),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CompassRadii.xl),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CompassRadii.xl),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(CompassRadii.xl),
                      borderSide: BorderSide(
                        color: scheme.primary.withOpacity(0.35),
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: CompassSpacing.lg,
                      vertical: CompassSpacing.md,
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
              const SizedBox(width: CompassSpacing.xs),
              Material(
                color: sending
                    ? scheme.primary.withOpacity(0.45)
                    : scheme.primary,
                shape: const CircleBorder(),
                elevation: sending ? 0 : 2,
                shadowColor: scheme.primary.withOpacity(0.4),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: sending ? null : onSend,
                  customBorder: const CircleBorder(),
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Center(
                      child: sending
                          ? SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.4,
                                color: scheme.onPrimary,
                              ),
                            )
                          : Icon(
                              Icons.arrow_upward_rounded,
                              size: 28,
                              color: scheme.onPrimary,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
