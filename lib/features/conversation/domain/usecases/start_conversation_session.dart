import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/services/compass/compass_engine_service.dart';

class StartConversationSessionParams {
  const StartConversationSessionParams({
    required this.userId,
    required this.mode,
    this.title,
    this.prompt,
    this.targetSkillId,
  });

  final String userId;
  final SessionMode mode;
  final String? title;
  final String? prompt;
  final String? targetSkillId;
}

class StartConversationSession
    extends UseCase<ConversationSession, StartConversationSessionParams> {
  StartConversationSession(this._engine);

  final CompassEngineService _engine;

  @override
  Future<Result<ConversationSession>> call(
    StartConversationSessionParams params,
  ) {
    return _engine.startSession(
      userId: params.userId,
      mode: params.mode,
      title: params.title,
      prompt: params.prompt,
      targetSkillId: params.targetSkillId,
    );
  }
}
