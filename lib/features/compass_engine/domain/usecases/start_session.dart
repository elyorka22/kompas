import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class StartSessionParams {
  const StartSessionParams({
    required this.userId,
    this.mode,
    this.exerciseId,
    this.title,
    this.prompt,
    this.targetSkillId,
  });

  final String userId;
  final PracticeMode? mode;
  final String? exerciseId;
  final String? title;
  final String? prompt;
  final String? targetSkillId;
}

class StartSession extends UseCase<ConversationSession, StartSessionParams> {
  StartSession(this._engine);

  final CompassEngineService _engine;

  @override
  Future<Result<ConversationSession>> call(StartSessionParams params) {
    return _engine.startSession(
      userId: params.userId,
      mode: params.mode,
      exerciseId: params.exerciseId,
      title: params.title,
      prompt: params.prompt,
      targetSkillId: params.targetSkillId,
    );
  }
}
