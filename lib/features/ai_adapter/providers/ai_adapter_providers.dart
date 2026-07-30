import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompas/core/providers/core_providers.dart';
import 'package:kompas/features/ai_adapter/domain/ai_adapter.dart';

/// Re-export for feature-local imports.
final offlineAiAdapterProvider = Provider<AiAdapter>((ref) {
  return ref.watch(aiAdapterProvider);
});
