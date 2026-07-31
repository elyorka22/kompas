/// PCM capture + lightweight VAD / silence trim (16 kHz mono).
library;

import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioPipeline {
  AudioPipeline({AudioRecorder? recorder}) : _recorder = recorder ?? AudioRecorder();

  final AudioRecorder _recorder;
  String? _activePath;

  bool get isRecording => _activePath != null;

  Future<bool> hasPermission() => _recorder.hasPermission();

  Future<void> startListening() async {
    if (_activePath != null) {
      await cancel();
    }
    final ok = await _recorder.hasPermission();
    if (!ok) {
      throw StateError('Microphone permission denied');
    }

    final dir = await getTemporaryDirectory();
    final path = p.join(
      dir.path,
      'kompas_speech_${DateTime.now().millisecondsSinceEpoch}.wav',
    );

    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.wav,
        sampleRate: 16000,
        numChannels: 1,
        bitRate: 256000,
        // Platform noise suppression where available.
        autoGain: true,
        echoCancel: true,
        noiseSuppress: true,
      ),
      path: path,
    );
    _activePath = path;
  }

  Future<String?> stopListening({bool trimSilence = true}) async {
    final path = _activePath;
    _activePath = null;
    final stopped = await _recorder.stop();
    final resolved = stopped ?? path;
    if (resolved == null) return null;
    if (!trimSilence) return resolved;
    return _trimSilenceInIsolate(resolved);
  }

  Future<void> cancel() async {
    _activePath = null;
    try {
      if (await _recorder.isRecording()) {
        await _recorder.stop();
      }
    } catch (_) {}
  }

  Future<void> dispose() async {
    await cancel();
    await _recorder.dispose();
  }

  Future<String> _trimSilenceInIsolate(String path) async {
    try {
      return await compute(_trimWavSilence, path);
    } catch (e, st) {
      debugPrint('AudioPipeline trim failed: $e\n$st');
      return path;
    }
  }
}

/// Energy-based leading/trailing silence trim for 16-bit mono WAV.
String _trimWavSilence(String path) {
  final file = File(path);
  if (!file.existsSync()) return path;
  final bytes = file.readAsBytesSync();
  if (bytes.length < 44) return path;

  // Minimal WAV parse: assume PCM 16-bit mono after 44-byte header.
  const header = 44;
  final pcm = bytes.sublist(header);
  if (pcm.length < 2) return path;

  final samples = Int16List.view(
    pcm.buffer,
    pcm.offsetInBytes,
    pcm.lengthInBytes ~/ 2,
  );

  const frame = 480; // 30 ms @ 16 kHz
  final threshold = _noiseFloor(samples) * 3.5 + 350;

  var start = 0;
  for (var i = 0; i + frame < samples.length; i += frame) {
    if (_rms(samples, i, frame) >= threshold) {
      start = math.max(0, i - frame);
      break;
    }
  }

  var end = samples.length;
  for (var i = samples.length - frame; i >= 0; i -= frame) {
    if (_rms(samples, i, frame) >= threshold) {
      end = math.min(samples.length, i + frame * 2);
      break;
    }
  }

  if (end <= start + frame) return path;

  final trimmed = samples.sublist(start, end);
  final outBytes = BytesBuilder()
    ..add(bytes.sublist(0, 44))
    ..add(
      Uint8List.view(
        trimmed.buffer,
        trimmed.offsetInBytes,
        trimmed.lengthInBytes,
      ),
    );
  final built = outBytes.toBytes();
  // Patch data size + file size in WAV header.
  final dataSize = trimmed.lengthInBytes;
  final byteData = ByteData.sublistView(built);
  byteData.setUint32(4, 36 + dataSize, Endian.little);
  byteData.setUint32(40, dataSize, Endian.little);

  final outPath = path.replaceFirst('.wav', '_trim.wav');
  File(outPath).writeAsBytesSync(built);
  return outPath;
}

double _rms(Int16List samples, int offset, int length) {
  var sum = 0.0;
  final end = math.min(samples.length, offset + length);
  for (var i = offset; i < end; i++) {
    final v = samples[i].toDouble();
    sum += v * v;
  }
  final n = end - offset;
  if (n <= 0) return 0;
  return math.sqrt(sum / n);
}

double _noiseFloor(Int16List samples) {
  const probe = 1600; // first ~100 ms
  final end = math.min(samples.length, probe);
  if (end <= 0) return 200;
  return _rms(samples, 0, end);
}
