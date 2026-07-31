/// Download / verify / delete Whisper GGML models (not bundled in APK).
library;

import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:kompas/speech/speech_model_catalog.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

typedef ModelDownloadProgress = void Function(int received, int total);

class SpeechModelManager {
  SpeechModelManager({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  Directory? _modelsDir;

  Future<Directory> modelsDirectory() async {
    if (_modelsDir != null) return _modelsDir!;
    final support = await getApplicationSupportDirectory();
    final dir = Directory(p.join(support.path, 'speech_models'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    _modelsDir = dir;
    return dir;
  }

  Future<File> modelFile(SpeechModelProfile profile) async {
    final dir = await modelsDirectory();
    return File(p.join(dir.path, profile.fileName));
  }

  Future<File> pluginAliasFile(SpeechModelProfile profile) async {
    final dir = await modelsDirectory();
    return File(p.join(dir.path, profile.pluginAliasFileName));
  }

  Future<bool> isDownloaded(SpeechModelProfile profile) async {
    final file = await modelFile(profile);
    if (!await file.exists()) return false;
    final len = await file.length();
    if (len < profile.approximateBytes * 0.95) return false;
    final meta = await _metaFile(profile);
    if (!await meta.exists()) return false;
    try {
      final map = jsonDecode(await meta.readAsString()) as Map<String, dynamic>;
      return map['sha256'] == profile.sha256 && map['ok'] == true;
    } catch (_) {
      return false;
    }
  }

  Future<int?> bytesOnDisk(SpeechModelProfile profile) async {
    final file = await modelFile(profile);
    if (!await file.exists()) return null;
    return file.length();
  }

  Future<void> download(
    SpeechModelProfile profile, {
    ModelDownloadProgress? onProgress,
  }) async {
    final file = await modelFile(profile);
    final temp = File('${file.path}.part');
    if (await temp.exists()) {
      await temp.delete();
    }

    final request = http.Request('GET', Uri.parse(profile.downloadUrl));
    final response = await _client.send(request);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError(
        'Model download failed (${response.statusCode}) for ${profile.fileName}',
      );
    }

    final total = response.contentLength ?? profile.approximateBytes;
    var received = 0;
    final sink = temp.openWrite();
    try {
      await for (final chunk in response.stream) {
        sink.add(chunk);
        received += chunk.length;
        onProgress?.call(received, total);
      }
      await sink.flush();
    } finally {
      await sink.close();
    }

    final digest = await _sha256File(temp);
    if (digest != profile.sha256) {
      await temp.delete();
      throw StateError(
        'SHA256 mismatch for ${profile.fileName}. '
        'Expected ${profile.sha256}, got $digest',
      );
    }

    if (await file.exists()) {
      await file.delete();
    }
    await temp.rename(file.path);
    await _writeMeta(profile, digest);
    await _syncPluginAlias(profile);
  }

  /// Ensures whisper_flutter_new can open ggml-small.bin / ggml-base.bin.
  Future<void> _syncPluginAlias(SpeechModelProfile profile) async {
    final source = await modelFile(profile);
    final alias = await pluginAliasFile(profile);
    if (!await source.exists()) return;
    if (await alias.exists()) {
      await alias.delete();
    }
    try {
      await Link(alias.path).create(source.path);
    } catch (_) {
      await source.copy(alias.path);
    }
  }

  Future<void> ensurePluginAlias(SpeechModelProfile profile) =>
      _syncPluginAlias(profile);

  Future<void> delete(SpeechModelProfile profile) async {
    final file = await modelFile(profile);
    final alias = await pluginAliasFile(profile);
    final meta = await _metaFile(profile);
    if (await file.exists()) await file.delete();
    if (await alias.exists()) await alias.delete();
    if (await meta.exists()) await meta.delete();
  }

  Future<File> _metaFile(SpeechModelProfile profile) async {
    final dir = await modelsDirectory();
    return File(p.join(dir.path, '${profile.fileName}.meta.json'));
  }

  Future<void> _writeMeta(SpeechModelProfile profile, String sha256) async {
    final meta = await _metaFile(profile);
    await meta.writeAsString(
      jsonEncode({
        'fileName': profile.fileName,
        'sha256': sha256,
        'ok': true,
        'downloadedAt': DateTime.now().toUtc().toIso8601String(),
        'language': kSpeechLanguageCode,
      }),
    );
  }

  Future<String> _sha256File(File file) async {
    final digest = await sha256.bind(file.openRead()).first;
    return digest.toString();
  }
}
