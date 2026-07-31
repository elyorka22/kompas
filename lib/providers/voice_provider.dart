/// Riverpod wiring for the global [SpeechEngine] (Whisper behind the façade).
library;

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/models/voice_state.dart';
import 'package:kompas/speech/speech_engine.dart';
import 'package:kompas/speech/speech_model_catalog.dart';
import 'package:kompas/speech/whisper_speech_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kAutoSendKey = 'voice_auto_send_after_recognition';

final speechEngineProvider = Provider<SpeechEngine>((ref) {
  return WhisperSpeechEngine.instance;
});

final voiceStateProvider =
    StateNotifierProvider<VoiceStateNotifier, VoiceState>((ref) {
  return VoiceStateNotifier(ref.watch(speechEngineProvider));
});

class VoiceStateNotifier extends StateNotifier<VoiceState> {
  VoiceStateNotifier(this._engine) : super(const VoiceState()) {
    _statusSub = _engine.statusStream.listen(_onStatus);
    _partialSub = _engine.partialTextStream.listen((text) {
      state = state.copyWith(partialText: text, committedText: text);
    });
    _syncFromEngine();
  }

  final SpeechEngine _engine;
  StreamSubscription<SpeechEngineStatus>? _statusSub;
  StreamSubscription<String>? _partialSub;

  void _syncFromEngine() {
    state = state.copyWith(
      status: _mapStatus(_engine.status),
      isModelLoaded: _engine.isModelLoaded,
      errorMessage: _engine.lastError,
      downloadProgress: _engine.downloadProgress,
      clearError: _engine.lastError == null,
    );
  }

  void _onStatus(SpeechEngineStatus status) {
    state = state.copyWith(
      status: _mapStatus(status),
      isModelLoaded: _engine.isModelLoaded,
      errorMessage: _engine.lastError,
      downloadProgress: _engine.downloadProgress,
      clearError: status != SpeechEngineStatus.error,
    );
  }

  VoiceStatus _mapStatus(SpeechEngineStatus status) {
    return switch (status) {
      SpeechEngineStatus.idle => VoiceStatus.idle,
      SpeechEngineStatus.checkingModel ||
      SpeechEngineStatus.loadingModel =>
        VoiceStatus.initializing,
      SpeechEngineStatus.downloading => VoiceStatus.downloading,
      SpeechEngineStatus.ready => VoiceStatus.ready,
      SpeechEngineStatus.listening => VoiceStatus.listening,
      SpeechEngineStatus.processing => VoiceStatus.processing,
      SpeechEngineStatus.error => VoiceStatus.error,
    };
  }

  Future<void> initialize() => _engine.initialize();

  Future<void> startListening() async {
    state = state.copyWith(
      partialText: '',
      committedText: '',
      clearError: true,
    );
    await _engine.startListening();
  }

  Future<String> stopListening() async {
    final result = await _engine.stopListening();
    final text = result.text;
    state = state.copyWith(
      committedText: text,
      partialText: '',
      status: VoiceStatus.ready,
    );
    return text;
  }

  Future<void> cancelListening() async {
    await _engine.cancel();
    state = state.copyWith(
      partialText: '',
      committedText: '',
      status: _mapStatus(_engine.status),
    );
  }

  @override
  void dispose() {
    _statusSub?.cancel();
    _partialSub?.cancel();
    super.dispose();
  }
}

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
  }

  Future<void> setEnabled(bool value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kAutoSendKey, value);
  }
}

final speechModelIdProvider =
    StateNotifierProvider<SpeechModelIdNotifier, SpeechModelId>((ref) {
  return SpeechModelIdNotifier(ref.watch(speechEngineProvider));
});

class SpeechModelIdNotifier extends StateNotifier<SpeechModelId> {
  SpeechModelIdNotifier(this._engine) : super(_engine.activeModelId);

  final SpeechEngine _engine;

  Future<void> select(SpeechModelId id) async {
    state = id;
    await _engine.setActiveModel(id);
  }
}
