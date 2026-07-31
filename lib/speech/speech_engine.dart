/// Abstract offline speech recognition port for Compass.
///
/// Coach / Memory / Prompt / UI must depend only on this API — never on Whisper.
library;

import 'package:kompas/speech/recognition_result.dart';
import 'package:kompas/speech/speech_model_catalog.dart';

typedef SpeechDownloadProgress = void Function(int received, int total);
typedef SpeechPartialListener = void Function(String partialText);

enum SpeechEngineStatus {
  idle,
  checkingModel,
  downloading,
  loadingModel,
  ready,
  listening,
  processing,
  error,
}

/// Production speech façade — Russian only.
abstract class SpeechEngine {
  SpeechEngineStatus get status;
  SpeechModelId get activeModelId;
  bool get isModelLoaded;
  bool get isListening;
  String? get lastError;
  double get downloadProgress;

  Stream<SpeechEngineStatus> get statusStream;
  Stream<String> get partialTextStream;

  Future<void> initialize({SpeechModelId? modelId});

  Future<void> downloadModel({
    SpeechModelId? modelId,
    SpeechDownloadProgress? onProgress,
  });

  Future<void> loadModel({SpeechModelId? modelId});

  Future<void> unloadModel();

  Future<void> startListening();

  Future<RecognitionResult> stopListening();

  Future<void> cancel();

  Future<RecognitionResult> transcribeFile(String audioPath);

  /// Records until [stopListening]/ emits partials when available.
  Future<void> transcribeStream({SpeechPartialListener? onPartial});

  Future<bool> isModelDownloaded([SpeechModelId? modelId]);

  Future<int?> modelBytesOnDisk([SpeechModelId? modelId]);

  Future<void> deleteModel([SpeechModelId? modelId]);

  Future<void> setActiveModel(SpeechModelId modelId);

  Future<void> dispose();
}
