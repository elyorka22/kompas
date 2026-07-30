import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/finished_session_result.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class FinishSessionParams {
  const FinishSessionParams({
    required this.session,
    required this.speakingSeconds,
  });

  final ConversationSession session;
  final int speakingSeconds;
}

class FinishSession extends UseCase<FinishedSessionResult, FinishSessionParams> {
  FinishSession(this._engine);

  final CompassEngineService _engine;

  @override
  Future<Result<FinishedSessionResult>> call(FinishSessionParams params) {
    return _engine.finishSession(
      session: params.session,
      speakingSeconds: params.speakingSeconds,
    );
  }
}
