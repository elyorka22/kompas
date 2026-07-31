/// Russian-only Whisper model catalog (extensible later — do not add langs now).
library;

/// Active recognition language for Compass. Fixed to Russian.
const String kSpeechLanguageCode = 'ru';

enum SpeechModelId {
  /// Default — accuracy-first mobile choice (~181 MB).
  smallQ51,

  /// Lighter fallback (~57 MB).
  baseQ51,
}

class SpeechModelProfile {
  const SpeechModelProfile({
    required this.id,
    required this.fileName,
    required this.displayName,
    required this.downloadUrl,
    required this.sha256,
    required this.approximateBytes,
    required this.pluginAliasFileName,
  });

  final SpeechModelId id;

  /// Canonical on-disk name (ggml-*-q5_1.bin).
  final String fileName;

  final String displayName;
  final String downloadUrl;
  final String sha256;
  final int approximateBytes;

  /// Filename expected by whisper_flutter_new (ggml-small.bin / ggml-base.bin).
  final String pluginAliasFileName;

  String get sizeLabel {
    final mb = approximateBytes / (1024 * 1024);
    return '${mb.toStringAsFixed(0)} MB';
  }
}

abstract final class SpeechModelCatalog {
  static const small = SpeechModelProfile(
    id: SpeechModelId.smallQ51,
    fileName: 'ggml-small-q5_1.bin',
    displayName: 'Small (рекомендуется)',
    downloadUrl:
        'https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small-q5_1.bin',
    sha256:
        'ae85e4a935d7a567bd102fe55afc16bb595bdb618e11b2fc7591bc08120411bb',
    approximateBytes: 190085487,
    pluginAliasFileName: 'ggml-small.bin',
  );

  static const base = SpeechModelProfile(
    id: SpeechModelId.baseQ51,
    fileName: 'ggml-base-q5_1.bin',
    displayName: 'Base',
    downloadUrl:
        'https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base-q5_1.bin',
    sha256:
        '422f1ae452ade6f30a004d7e5c6a43195e4433bc370bf23fac9cc591f01a8898',
    approximateBytes: 59707625,
    pluginAliasFileName: 'ggml-base.bin',
  );

  static const List<SpeechModelProfile> all = [small, base];

  static SpeechModelProfile byId(SpeechModelId id) {
    return switch (id) {
      SpeechModelId.smallQ51 => small,
      SpeechModelId.baseQ51 => base,
    };
  }

  static SpeechModelId parseId(String? raw) {
    return switch (raw) {
      'baseQ51' || 'base' => SpeechModelId.baseQ51,
      _ => SpeechModelId.smallQ51,
    };
  }
}
