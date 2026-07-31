/// Global offline speech-to-text powered by Vosk.
///
/// One singleton instance is shared across Coach chat, search, notes, and any
/// future TextField that attaches [VoiceInputButton].
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kompas/models/voice_state.dart';
import 'package:kompas/utils/speech_permissions.dart';
import 'package:vosk_flutter/vosk_flutter.dart';

typedef VoiceStateListener = void Function(VoiceState state);

/// Asset path of the Russian small model zip (must be listed in pubspec).
const String kVoskRuModelAsset =
    'assets/models/vosk-model-small-ru-0.22.zip';

const int _kSampleRate = 16000;

/// Production Vosk wrapper — load model once, reuse recognizer / speech service.
class VoiceInputService {
  VoiceInputService._();

  static final VoiceInputService instance = VoiceInputService._();

  final List<VoiceStateListener> _listeners = [];

  VoiceState _state = const VoiceState();
  VoiceState get state => _state;

  VoskFlutterPlugin? _vosk;
  Model? _model;
  Recognizer? _recognizer;
  SpeechService? _speech;

  StreamSubscription<String>? _partialSub;
  StreamSubscription<String>? _resultSub;

  Future<void>? _initFuture;
  bool _disposed = false;

  /// Prefers replacing the field; when false, appends after existing text.
  bool replaceExistingText = true;

  /// Optional auto-send after the user stops listening (Coach chat).
  bool autoSendAfterRecognition = false;

  void addListener(VoiceStateListener listener) {
    _listeners.add(listener);
  }

  void removeListener(VoiceStateListener listener) {
    _listeners.remove(listener);
  }

  void _emit(VoiceState next) {
    _state = next;
    for (final listener in List<VoiceStateListener>.from(_listeners)) {
      listener(_state);
    }
  }

  /// Loads the Vosk model once. Safe to call repeatedly.
  Future<void> initialize({String modelAsset = kVoskRuModelAsset}) {
    if (_disposed) {
      return Future.error(StateError('VoiceInputService was disposed'));
    }
    if (_state.isModelLoaded && _speech != null) {
      return Future.value();
    }
    return _initFuture ??= _doInitialize(modelAsset);
  }

  Future<void> _doInitialize(String modelAsset) async {
    _emit(
      _state.copyWith(
        status: VoiceStatus.initializing,
        clearError: true,
      ),
    );

    try {
      if (kIsWeb) {
        throw UnsupportedError('Vosk voice input is not available on web.');
      }
      if (!Platform.isAndroid) {
        // Upstream vosk_flutter SpeechService is Android-only.
        throw UnsupportedError(
          'Offline voice input with Vosk SpeechService is currently '
          'supported on Android. iOS support requires a native Vosk build.',
        );
      }

      await _assertModelAssetExists(modelAsset);

      _vosk = VoskFlutterPlugin.instance();
      final modelPath = await ModelLoader().loadFromAssets(modelAsset);
      _model = await _vosk!.createModel(modelPath);
      _recognizer = await _vosk!.createRecognizer(
        model: _model!,
        sampleRate: _kSampleRate,
      );
      _speech = await _vosk!.initSpeechService(_recognizer!);

      _emit(
        const VoiceState(
          status: VoiceStatus.ready,
          isModelLoaded: true,
        ),
      );
    } catch (e, st) {
      debugPrint('VoiceInputService.initialize failed: $e\n$st');
      _initFuture = null;
      _emit(
        VoiceState(
          status: VoiceStatus.error,
          errorMessage: _friendlyInitError(e),
          isModelLoaded: false,
        ),
      );
      rethrow;
    }
  }

  Future<void> _assertModelAssetExists(String asset) async {
    try {
      await rootBundle.load(asset);
    } catch (_) {
      throw StateError(
        'Missing Vosk model asset "$asset". '
        'Run scripts/download_vosk_model.sh and rebuild.',
      );
    }
  }

  String _friendlyInitError(Object e) {
    final msg = e.toString();
    if (msg.contains('Missing Vosk model')) {
      return 'Речевая модель не найдена. Добавьте Vosk-модель и пересоберите приложение.';
    }
    if (e is UnsupportedError) {
      return e.message ?? msg;
    }
    return 'Не удалось инициализировать распознавание речи. Попробуйте ещё раз.';
  }

  /// Starts continuous listening. Initializes on first use.
  Future<void> startListening() async {
    if (_disposed) return;
    if (_state.isListening) return;

    try {
      final granted = await SpeechPermissions.ensureMicrophonePermission();
      if (!granted) {
        final permanent = await SpeechPermissions.isPermanentlyDenied();
        _emit(
          _state.copyWith(
            status: VoiceStatus.error,
            errorMessage: permanent
                ? 'Доступ к микрофону запрещён. Разрешите его в настройках системы.'
                : 'Нужен доступ к микрофону для голосового ввода.',
          ),
        );
        return;
      }

      await initialize();
      if (_speech == null) return;

      await _detachStreams();
      _partialSub = _speech!.onPartial().listen(_onPartialJson);
      _resultSub = _speech!.onResult().listen(_onResultJson);

      await _speech!.start();
      _emit(
        _state.copyWith(
          status: VoiceStatus.listening,
          partialText: '',
          committedText: '',
          clearError: true,
        ),
      );
    } catch (e, st) {
      debugPrint('VoiceInputService.startListening failed: $e\n$st');
      _emit(
        _state.copyWith(
          status: VoiceStatus.error,
          errorMessage: _state.errorMessage ??
              'Микрофон недоступен или распознавание не запустилось.',
        ),
      );
    }
  }

  /// Stops listening and keeps the last committed / partial text in state.
  Future<String> stopListening() async {
    if (_disposed) return _state.liveText;
    if (!_state.isListening && _speech == null) return _state.liveText;

    _emit(_state.copyWith(status: VoiceStatus.processing));
    try {
      await _speech?.stop();
    } catch (e) {
      debugPrint('VoiceInputService.stopListening: $e');
    }

    // Promote remaining partial into committed text.
    final finalText = _state.liveText.trim();
    await _detachStreams();
    _emit(
      _state.copyWith(
        status: VoiceStatus.ready,
        committedText: finalText,
        partialText: '',
        clearError: true,
      ),
    );
    return finalText;
  }

  /// Cancels recognition and clears the current session transcript.
  Future<void> cancelListening() async {
    if (_disposed) return;
    try {
      await _speech?.cancel();
    } catch (e) {
      debugPrint('VoiceInputService.cancelListening: $e');
    }
    await _detachStreams();
    _emit(
      _state.copyWith(
        status: VoiceStatus.ready,
        partialText: '',
        committedText: '',
        clearError: true,
      ),
    );
  }

  void _onPartialJson(String raw) {
    final text = _extractField(raw, 'partial');
    if (text == null) return;
    _emit(_state.copyWith(partialText: text));
  }

  void _onResultJson(String raw) {
    final text = _extractField(raw, 'text');
    if (text == null || text.trim().isEmpty) return;
    final previous = _state.committedText.trim();
    final next = previous.isEmpty ? text.trim() : '$previous ${text.trim()}';
    _emit(
      _state.copyWith(
        committedText: next,
        partialText: '',
      ),
    );
  }

  String? _extractField(String raw, String key) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map && decoded[key] is String) {
        return decoded[key] as String;
      }
    } catch (_) {
      // Some builds may already emit plain text.
      final trimmed = raw.trim();
      if (trimmed.isNotEmpty && !trimmed.startsWith('{')) {
        return trimmed;
      }
    }
    return null;
  }

  Future<void> _detachStreams() async {
    await _partialSub?.cancel();
    await _resultSub?.cancel();
    _partialSub = null;
    _resultSub = null;
  }

  /// Releases native resources. Prefer keeping the singleton for the app life.
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await cancelListening();
    try {
      await _speech?.dispose();
    } catch (_) {}
    _speech = null;
    _recognizer = null;
    _model = null;
    _vosk = null;
    _initFuture = null;
    _listeners.clear();
    _emit(const VoiceState());
  }
}
