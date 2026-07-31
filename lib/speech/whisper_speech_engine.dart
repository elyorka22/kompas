/// Whisper.cpp-backed [SpeechEngine] — Russian only. No other module imports this.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kompas/speech/audio_pipeline.dart';
import 'package:kompas/speech/model_manager.dart';
import 'package:kompas/speech/recognition_result.dart';
import 'package:kompas/speech/speech_engine.dart';
import 'package:kompas/speech/speech_model_catalog.dart';
import 'package:kompas/speech/speech_post_processor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whisper_flutter_new/whisper_flutter_new.dart';

const _kPrefsModelKey = 'speech_engine_model_id';

/// Singleton Whisper offline engine optimized for Russian.
class WhisperSpeechEngine implements SpeechEngine {
  WhisperSpeechEngine._({
    SpeechModelManager? modelManager,
    AudioPipeline? audioPipeline,
    SpeechPostProcessor? postProcessor,
  })  : _models = modelManager ?? SpeechModelManager(),
        _audio = audioPipeline ?? AudioPipeline(),
        _post = postProcessor ?? const SpeechPostProcessor();

  static final WhisperSpeechEngine instance = WhisperSpeechEngine._();

  final SpeechModelManager _models;
  final AudioPipeline _audio;
  final SpeechPostProcessor _post;

  final _statusController =
      StreamController<SpeechEngineStatus>.broadcast();
  final _partialController = StreamController<String>.broadcast();

  SpeechEngineStatus _status = SpeechEngineStatus.idle;
  SpeechModelId _activeModelId = SpeechModelId.smallQ51;
  Whisper? _whisper;
  bool _modelLoaded = false;
  bool _disposed = false;
  String? _lastError;
  double _downloadProgress = 0;
  DateTime? _listenStartedAt;
  Future<void>? _initFuture;

  @override
  SpeechEngineStatus get status => _status;

  @override
  SpeechModelId get activeModelId => _activeModelId;

  @override
  bool get isModelLoaded => _modelLoaded;

  @override
  bool get isListening => _status == SpeechEngineStatus.listening;

  @override
  String? get lastError => _lastError;

  @override
  double get downloadProgress => _downloadProgress;

  @override
  Stream<SpeechEngineStatus> get statusStream => _statusController.stream;

  @override
  Stream<String> get partialTextStream => _partialController.stream;

  void _setStatus(SpeechEngineStatus next) {
    _status = next;
    if (!_statusController.isClosed) {
      _statusController.add(next);
    }
  }

  @override
  Future<void> initialize({SpeechModelId? modelId}) {
    if (_disposed) {
      return Future.error(StateError('SpeechEngine disposed'));
    }
    return _initFuture ??= _doInitialize(modelId);
  }

  Future<void> _doInitialize(SpeechModelId? modelId) async {
    try {
      await _restoreModelPreference();
      if (modelId != null) {
        _activeModelId = modelId;
      }
      _setStatus(SpeechEngineStatus.checkingModel);
      final profile = SpeechModelCatalog.byId(_activeModelId);
      if (!await _models.isDownloaded(profile)) {
        await downloadModel(modelId: _activeModelId);
      } else {
        await _models.ensurePluginAlias(profile);
      }
      await loadModel(modelId: _activeModelId);
    } catch (e, st) {
      debugPrint('SpeechEngine.initialize failed: $e\n$st');
      _lastError = e.toString();
      _setStatus(SpeechEngineStatus.error);
      _initFuture = null;
      rethrow;
    }
  }

  Future<void> _restoreModelPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _activeModelId = SpeechModelCatalog.parseId(prefs.getString(_kPrefsModelKey));
  }

  Future<void> _persistModelPreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPrefsModelKey, _activeModelId.name);
  }

  @override
  Future<void> downloadModel({
    SpeechModelId? modelId,
    SpeechDownloadProgress? onProgress,
  }) async {
    final id = modelId ?? _activeModelId;
    final profile = SpeechModelCatalog.byId(id);
    _setStatus(SpeechEngineStatus.downloading);
    _downloadProgress = 0;
    _lastError = null;
    try {
      await _models.download(
        profile,
        onProgress: (received, total) {
          _downloadProgress = total <= 0 ? 0 : received / total;
          onProgress?.call(received, total);
        },
      );
      _downloadProgress = 1;
    } catch (e) {
      _lastError = e.toString();
      _setStatus(SpeechEngineStatus.error);
      rethrow;
    }
  }

  @override
  Future<void> loadModel({SpeechModelId? modelId}) async {
    final id = modelId ?? _activeModelId;
    final profile = SpeechModelCatalog.byId(id);
    if (!await _models.isDownloaded(profile)) {
      throw StateError('Model ${profile.fileName} is not downloaded');
    }
    await _models.ensurePluginAlias(profile);

    _setStatus(SpeechEngineStatus.loadingModel);
    final dir = await _models.modelsDirectory();
    final pluginModel = switch (id) {
      SpeechModelId.smallQ51 => WhisperModel.small,
      SpeechModelId.baseQ51 => WhisperModel.base,
    };

    // Existing alias satisfies whisper_flutter_new and prevents full-model download.
    _whisper = Whisper(model: pluginModel, modelDir: dir.path);
    // Warm path: touch version (opens native lib) without requiring audio.
    try {
      await _whisper!.getVersion();
    } catch (_) {
      // Some builds only open lib on transcribe — ignore warm failures.
    }

    _activeModelId = id;
    _modelLoaded = true;
    await _persistModelPreference();
    _setStatus(SpeechEngineStatus.ready);
  }

  @override
  Future<void> unloadModel() async {
    _whisper = null;
    _modelLoaded = false;
    _setStatus(SpeechEngineStatus.idle);
  }

  @override
  Future<void> startListening() async {
    await initialize();
    final granted = await _audio.hasPermission();
    if (!granted) {
      _lastError = 'Нужен доступ к микрофону для голосового ввода.';
      _setStatus(SpeechEngineStatus.error);
      throw StateError(_lastError!);
    }
    await _audio.startListening();
    _listenStartedAt = DateTime.now();
    _partialController.add('');
    _setStatus(SpeechEngineStatus.listening);
  }

  @override
  Future<RecognitionResult> stopListening() async {
    if (_status != SpeechEngineStatus.listening && !_audio.isRecording) {
      return const RecognitionResult(rawText: '', normalizedText: '');
    }
    _setStatus(SpeechEngineStatus.processing);
    final path = await _audio.stopListening(trimSilence: true);
    final durationMs = _listenStartedAt == null
        ? 0
        : DateTime.now().difference(_listenStartedAt!).inMilliseconds;
    _listenStartedAt = null;
    if (path == null) {
      _setStatus(SpeechEngineStatus.ready);
      return const RecognitionResult(rawText: '', normalizedText: '');
    }
    try {
      final result = await transcribeFile(path);
      _setStatus(SpeechEngineStatus.ready);
      return RecognitionResult(
        rawText: result.rawText,
        normalizedText: result.normalizedText,
        confidence: result.confidence,
        segments: result.segments,
        durationMs: durationMs,
        processingTimeMs: result.processingTimeMs,
      );
    } catch (e, st) {
      debugPrint('SpeechEngine.stopListening failed: $e\n$st');
      _lastError = e.toString();
      _setStatus(SpeechEngineStatus.error);
      rethrow;
    }
  }

  @override
  Future<void> cancel() async {
    await _audio.cancel();
    _listenStartedAt = null;
    _partialController.add('');
    if (_modelLoaded) {
      _setStatus(SpeechEngineStatus.ready);
    } else {
      _setStatus(SpeechEngineStatus.idle);
    }
  }

  @override
  Future<RecognitionResult> transcribeFile(String audioPath) async {
    await initialize();
    final whisper = _whisper;
    if (whisper == null) {
      throw StateError('Whisper model is not loaded');
    }

    final started = DateTime.now();
    // Always force Russian — never auto-detect.
    final response = await whisper.transcribe(
      transcribeRequest: TranscribeRequest(
        audio: audioPath,
        language: kSpeechLanguageCode,
        isTranslate: false,
        isNoTimestamps: false,
        splitOnWord: true,
        threads: 4,
        nProcessors: 1,
        noFallback: false,
      ),
    );

    final raw = response.text.trim();
    final normalized = _post.process(raw);
    final segments = <SpeechSegment>[
      for (final s in response.segments ?? const <WhisperTranscribeSegment>[])
        SpeechSegment(
          text: s.text.trim(),
          startMs: s.fromTs.inMilliseconds,
          endMs: s.toTs.inMilliseconds,
        ),
    ];

    final result = RecognitionResult(
      rawText: raw,
      normalizedText: normalized,
      confidence: null,
      segments: segments,
      durationMs: segments.isEmpty
          ? 0
          : (segments.last.endMs - segments.first.startMs).clamp(0, 1 << 30),
      processingTimeMs: DateTime.now().difference(started).inMilliseconds,
    );
    _partialController.add(result.text);
    return result;
  }

  @override
  Future<void> transcribeStream({SpeechPartialListener? onPartial}) async {
    // File-based Whisper: stream = listen until stopListening.
    await startListening();
    if (onPartial != null) {
      await for (final partial in partialTextStream) {
        onPartial(partial);
        if (_status != SpeechEngineStatus.listening) break;
      }
    }
  }

  @override
  Future<bool> isModelDownloaded([SpeechModelId? modelId]) {
    return _models.isDownloaded(
      SpeechModelCatalog.byId(modelId ?? _activeModelId),
    );
  }

  @override
  Future<int?> modelBytesOnDisk([SpeechModelId? modelId]) {
    return _models.bytesOnDisk(
      SpeechModelCatalog.byId(modelId ?? _activeModelId),
    );
  }

  @override
  Future<void> deleteModel([SpeechModelId? modelId]) async {
    final id = modelId ?? _activeModelId;
    if (id == _activeModelId) {
      await unloadModel();
    }
    await _models.delete(SpeechModelCatalog.byId(id));
  }

  @override
  Future<void> setActiveModel(SpeechModelId modelId) async {
    if (_activeModelId == modelId && _modelLoaded) return;
    await unloadModel();
    _activeModelId = modelId;
    await _persistModelPreference();
    await initialize(modelId: modelId);
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await cancel();
    await unloadModel();
    await _audio.dispose();
    await _statusController.close();
    await _partialController.close();
  }
}
