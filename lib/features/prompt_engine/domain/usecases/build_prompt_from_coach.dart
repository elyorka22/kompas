import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/coach_balance.dart';
import 'package:kompas/domain/entities/learning_strategy.dart';
import 'package:kompas/domain/entities/personal_learning_profile.dart';
import 'package:kompas/domain/entities/prompt_bundle.dart';
import 'package:kompas/domain/entities/prompt_request.dart';
import 'package:kompas/domain/enums/prompt_mode.dart';
import 'package:kompas/services/prompt/prompt_engine_service.dart';

class BuildPromptFromCoachParams {
  const BuildPromptFromCoachParams({
    required this.strategy,
    required this.profile,
    this.conversationGoal,
    this.memorySummary,
    this.conversationContext,
    this.overrideMode,
    this.insightLines = const [],
  });

  final LearningStrategy strategy;
  final PersonalLearningProfile profile;
  final ConversationGoal? conversationGoal;
  final PromptMemorySummary? memorySummary;
  final PromptConversationContext? conversationContext;
  final PromptMode? overrideMode;
  final List<String> insightLines;
}

class BuildPromptFromCoach
    extends UseCase<PromptBundle, BuildPromptFromCoachParams> {
  BuildPromptFromCoach(this._engine);

  final PromptEngineService _engine;

  @override
  Future<Result<PromptBundle>> call(BuildPromptFromCoachParams params) async {
    return _engine.buildFromCoach(
      strategy: params.strategy,
      profile: params.profile,
      conversationGoal: params.conversationGoal,
      memorySummary: params.memorySummary,
      conversationContext: params.conversationContext,
      overrideMode: params.overrideMode,
      insightLines: params.insightLines,
    );
  }
}
