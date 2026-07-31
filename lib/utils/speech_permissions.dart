/// Microphone permission helpers for global Vosk voice input.
library;

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

/// Requests and inspects microphone access for offline speech recognition.
abstract final class SpeechPermissions {
  /// Returns `true` when the app may open the microphone.
  static Future<bool> ensureMicrophonePermission() async {
    if (kIsWeb) return false;

    var status = await Permission.microphone.status;
    if (status.isGranted) return true;

    if (status.isDenied || status.isRestricted || status.isLimited) {
      status = await Permission.microphone.request();
      if (status.isGranted) return true;
    }

    return status.isGranted;
  }

  static Future<bool> isMicrophoneGranted() async {
    if (kIsWeb) return false;
    return Permission.microphone.isGranted;
  }

  static Future<bool> isPermanentlyDenied() async {
    if (kIsWeb) return false;
    final status = await Permission.microphone.status;
    return status.isPermanentlyDenied;
  }

  /// Opens OS settings so the user can re-enable the microphone.
  static Future<bool> openSystemSettings() => openAppSettings();
}
