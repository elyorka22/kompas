import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/repositories/statistics_repository.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';
import 'package:kompas/services/progress/progress_calculator_service.dart';

class CompleteConversationSessionParams {
  const CompleteConversationSessionParams({
    required this.session,
    required this.speakingSeconds,
  });

  final ConversationSession session;
  final int speakingSeconds;
}

class CompleteConversationSession
    extends UseCase<ConversationSession, CompleteConversationSessionParams> {
  CompleteConversationSession({
    required CompassEngineService compassEngine,
    required StatisticsRepository statisticsRepository,
    required ProgressCalculatorService progressCalculator,
  })  : _engine = compassEngine,
        _statistics = statisticsRepository,
        _progress = progressCalculator;

  final CompassEngineService _engine;
  final StatisticsRepository _statistics;
  final ProgressCalculatorService _progress;

  @override
  Future<Result<ConversationSession>> call(
    CompleteConversationSessionParams params,
  ) async {
    final completed = await _engine.completeSession(
      params.session,
      speakingSeconds: params.speakingSeconds,
    );
    if (completed.isFailure) return completed;

    final stats = await _statistics.getOrCreate(params.session.userId);
    if (stats.isSuccess) {
      final next = _progress.afterSpeaking(
        current: stats.valueOrNull!,
        speakingSeconds: params.speakingSeconds,
        sessionCompleted: true,
      );
      await _statistics.save(next);
    }

    return completed;
  }
}
