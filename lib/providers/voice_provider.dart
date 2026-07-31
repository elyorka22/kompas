/// Riverpod wiring for the global [VoiceInputService] singleton.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/models/voice_state.dart';
import 'package:kompas/services/voice_input_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kAutoSendKey = 'voice_auto_send_after_recognition';

final voiceInputServiceProvider = Provider<VoiceInputService>((ref) {
  final service = VoiceInputService.instance;
  ref.onDispose(() {
    // Keep native model warm for the process lifetime — do not dispose here.
  });
  return service;
});

/// Live [VoiceState] stream for widgets (mic button, listening indicator).
final voiceStateProvider =
    StateNotifierProvider<VoiceStateNotifier, VoiceState>((ref) {
  return VoiceStateNotifier(ref.watch(voiceInputServiceProvider));
});

class VoiceStateNotifier extends StateNotifier<VoiceState> {
  VoiceStateNotifier(this._service) : super(_service.state) {
    _service.addListener(_onService);
  }

  final VoiceInputService _service;

  void _onService(VoiceState next) {
    state = next;
  }

  Future<void> initialize() => _service.initialize();

  Future<void> startListening() => _service.startListening();

  Future<String> stopListening() => _service.stopListening();

  Future<void> cancelListening() => _service.cancelListening();

  @override
  void dispose() {
    _service.removeListener(_onService);
    super.dispose();
  }
}

/// Optional Coach setting: send the message when recognition stops.
final voiceAutoSendProvider =
    StateNotifierProvider<VoiceAutoSendNotifier, bool>((ref) {
  return VoiceAutoSendNotifier();
});

class VoiceAutoSendNotifier extends StateNotifier<bool> {
  VoiceAutoSendNotifier() : super(false) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_kAutoSendKey) ?? false;
    VoiceInputService.instance.autoSendAfterRecognition = state;
  }

  Future<void> setEnabled(bool value) async {
    state = value;
    VoiceInputService.instance.autoSendAfterRecognition = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kAutoSendKey, value);
  }
}
