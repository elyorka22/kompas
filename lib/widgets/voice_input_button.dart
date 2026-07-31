/// Animated mic control that binds [VoiceInputService] to a [TextEditingController].
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/design_system/design_system.dart';
import 'package:kompas/models/voice_state.dart';
import 'package:kompas/providers/voice_provider.dart';
import 'package:kompas/utils/speech_permissions.dart';
import 'package:kompas/widgets/listening_indicator.dart';

/// Reusable microphone button for any text field.
///
/// Usage:
/// ```dart
/// TextField(
///   controller: controller,
///   decoration: InputDecoration(
///     suffixIcon: VoiceInputButton(controller: controller),
///   ),
/// )
/// ```
class VoiceInputButton extends ConsumerStatefulWidget {
  const VoiceInputButton({
    super.key,
    required this.controller,
    this.onTextUpdated,
    this.onListeningStopped,
    this.enabled = true,
    this.tooltip,
    this.replaceExisting = true,
    this.showListeningSheet = true,
  });

  final TextEditingController controller;

  /// Called whenever live transcription updates the field.
  final ValueChanged<String>? onTextUpdated;

  /// Called after stop with the final recognized text.
  final ValueChanged<String>? onListeningStopped;

  final bool enabled;
  final String? tooltip;

  /// When true (default), recognition replaces the field contents.
  /// When false, recognized text is appended after a space.
  final bool replaceExisting;

  /// Shows a bottom sheet with stop / cancel while listening.
  final bool showListeningSheet;

  @override
  ConsumerState<VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends ConsumerState<VoiceInputButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  String _baseline = '';
  bool _sheetOpen = false;
  bool _stoppingFromSheet = false;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    final voice = ref.read(voiceStateProvider.notifier);
    final state = ref.read(voiceStateProvider);

    if (state.isListening) {
      await _stop();
      return;
    }

    _baseline = widget.replaceExisting ? '' : widget.controller.text.trim();
    await voice.startListening();
    final after = ref.read(voiceStateProvider);

    if (!mounted) return;

    if (after.hasError) {
      await _handleError(after);
      return;
    }

    if (after.isListening) {
      unawaited(_pulse.repeat(reverse: true));
      if (widget.showListeningSheet) {
        _openListeningSheet();
      }
    }
  }

  Future<void> _stop() async {
    _stoppingFromSheet = true;
    final text = await ref.read(voiceStateProvider.notifier).stopListening();
    _pulse.stop();
    _pulse.value = 0;
    _applyText(text, notifyStopped: true);
    if (_sheetOpen && mounted) {
      unawaited(Navigator.of(context).maybePop());
    }
    _stoppingFromSheet = false;
  }

  Future<void> _cancel() async {
    _stoppingFromSheet = true;
    await ref.read(voiceStateProvider.notifier).cancelListening();
    _pulse.stop();
    _pulse.value = 0;
    if (widget.replaceExisting) {
      widget.controller.text = _baseline;
    }
    widget.onTextUpdated?.call(widget.controller.text);
    if (_sheetOpen && mounted) {
      unawaited(Navigator.of(context).maybePop());
    }
    _stoppingFromSheet = false;
  }

  void _applyText(String recognized, {required bool notifyStopped}) {
    final trimmed = recognized.trim();
    String next;
    if (widget.replaceExisting || _baseline.isEmpty) {
      next = trimmed;
    } else if (trimmed.isEmpty) {
      next = _baseline;
    } else {
      next = '$_baseline $trimmed';
    }
    if (widget.controller.text == next) {
      if (notifyStopped) {
        widget.onListeningStopped?.call(next);
      }
      return;
    }
    widget.controller
      ..text = next
      ..selection = TextSelection.collapsed(offset: next.length);
    widget.onTextUpdated?.call(next);
    if (notifyStopped) {
      widget.onListeningStopped?.call(next);
    }
  }

  Future<void> _handleError(VoiceState state) async {
    final message = state.errorMessage ?? 'Ошибка голосового ввода';
    final permanent = await SpeechPermissions.isPermanentlyDenied();
    if (!mounted) return;
    CompassSnackbars.show(
      context,
      message: message,
      actionLabel: permanent ? 'Настройки' : 'Повтор',
      onAction: () async {
        if (permanent) {
          await SpeechPermissions.openSystemSettings();
        } else {
          await _toggle();
        }
      },
    );
  }

  void _openListeningSheet() {
    if (_sheetOpen) return;
    _sheetOpen = true;
    CompassBottomSheets.show<void>(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, _) {
            final voice = ref.watch(voiceStateProvider);
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                CompassSpacing.lg,
                CompassSpacing.md,
                CompassSpacing.lg,
                CompassSpacing.xl,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CompassSheetHandle(),
                  ListeningIndicator(
                    listening: voice.isListening,
                    label: voice.isListening ? 'Слушаю…' : 'Обрабатываю…',
                  ),
                  const SizedBox(height: CompassSpacing.md),
                  Text(
                    voice.liveText.isEmpty
                        ? 'Говорите на русском'
                        : voice.liveText,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: CompassSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: CompassSecondaryButton(
                          label: 'Отмена',
                          onPressed: _cancel,
                        ),
                      ),
                      const SizedBox(width: CompassSpacing.md),
                      Expanded(
                        child: CompassPrimaryButton(
                          label: 'Готово',
                          onPressed: _stop,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      _sheetOpen = false;
      final voice = ref.read(voiceStateProvider);
      if (!_stoppingFromSheet && voice.isListening) {
        _stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final voice = ref.watch(voiceStateProvider);
    final scheme = Theme.of(context).colorScheme;
    final listening = voice.isListening;

    ref.listen<VoiceState>(voiceStateProvider, (prev, next) {
      if (next.isListening || next.status == VoiceStatus.processing) {
        _applyText(next.liveText, notifyStopped: false);
      }
      if (next.hasError && prev?.hasError != true) {
        _handleError(next);
      }
    });

    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final scale = listening ? 1.0 + (_pulse.value * 0.12) : 1.0;
        return Transform.scale(scale: scale, child: child);
      },
      child: IconButton(
        tooltip: widget.tooltip ??
            (listening ? 'Остановить' : 'Голосовой ввод'),
        onPressed: widget.enabled ? _toggle : null,
        icon: Icon(
          listening ? Icons.mic_rounded : Icons.mic_none_rounded,
          color: listening ? scheme.error : null,
        ),
      ),
    );
  }
}
