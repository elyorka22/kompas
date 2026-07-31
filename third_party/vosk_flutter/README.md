# Vendored Vosk Flutter plugin

Source: [alphacep/vosk-flutter](https://github.com/alphacep/vosk-flutter) commit `02e300c` (http ^1.x bump).

## Why vendored?

| Source | Problem for Kompas |
|--------|--------------------|
| pub.dev `vosk_flutter` 0.3.48 | Declares `sdk: <3.0.0` (incompatible with Dart 3.4.4) |
| Git `e655a96` / `vosk_flutter_service` | Requires Dart ≥3.5.2 / Flutter ≥3.24 |

This tree keeps the Android SpeechService API and patches `environment` + `permission_handler` for Flutter 3.22.3.
