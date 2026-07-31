import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/conversation_message.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/personal_learning_profile.dart';
import 'package:kompas/domain/entities/prompt_request.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/prompt_mode.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/domain/repositories/conversation_repository.dart';
import 'package:kompas/features/ai_adapter/domain/ai_adapter.dart';
import 'package:kompas/features/coach_engine/domain/usecases/generate_learning_strategy.dart';
import 'package:kompas/features/coach_engine/domain/usecases/recommend_conversation_goal.dart';
import 'package:kompas/features/prompt_engine/domain/usecases/build_prompt_from_coach.dart';
import 'package:kompas/services/memory/memory_engine_service.dart';

class SendCoachTurnParams {
  const SendCoachTurnParams({
    required this.userId,
    required this.session,
    required this.profile,
    required this.userText,
    this.topic,
  });

  final String userId;
  final ConversationSession session;
  final PersonalLearningProfile profile;
  final String userText;
  final String? topic;
}

class SendCoachTurnResult {
  const SendCoachTurnResult({
    required this.userMessage,
    required this.coachMessage,
  });

  final ConversationMessage userMessage;
  final ConversationMessage coachMessage;
}

/// Orchestrates Coach + Memory + Prompt Engine + AiAdapter for one chat turn.
class SendCoachTurn extends UseCase<SendCoachTurnResult, SendCoachTurnParams> {
  SendCoachTurn({
    required AiAdapter aiAdapter,
    required ConversationRepository conversations,
    required GenerateLearningStrategy generateStrategy,
    required RecommendConversationGoal recommendGoal,
    required BuildPromptFromCoach buildPrompt,
    required MemoryEngineService memory,
  })  : _ai = aiAdapter,
        _conversations = conversations,
        _generateStrategy = generateStrategy,
        _recommendGoal = recommendGoal,
        _buildPrompt = buildPrompt,
        _memory = memory;

  final AiAdapter _ai;
  final ConversationRepository _conversations;
  final GenerateLearningStrategy _generateStrategy;
  final RecommendConversationGoal _recommendGoal;
  final BuildPromptFromCoach _buildPrompt;
  final MemoryEngineService _memory;

  @override
  Future<Result<SendCoachTurnResult>> call(SendCoachTurnParams params) async {
    final text = params.userText.trim();
    if (text.isEmpty) {
      return const Err(ValidationFailure('Message is empty.'));
    }

    final strategyResult = await _generateStrategy(
      GenerateLearningStrategyParams(userId: params.userId),
    );
    if (strategyResult.isFailure) {
      return Err(strategyResult.failureOrNull!);
    }
    final strategy = strategyResult.valueOrNull!;

    final goalResult = await _recommendGoal(
      RecommendConversationGoalParams(userId: params.userId),
    );
    final goal = goalResult.valueOrNull?.value;

    final insightsResult =
        await _memory.buildInsights(userId: params.userId);
    final insights = insightsResult.valueOrNull ?? const <String>[];

    final historyResult =
        await _conversations.listMessages(params.session.id);
    if (historyResult.isFailure) {
      return Err(historyResult.failureOrNull!);
    }
    final history = historyResult.valueOrNull!;

    final recentForPrompt = history
        .where((m) => m.role != MessageRole.system)
        .map((m) => m.content)
        .toList();

    final promptResult = await _buildPrompt(
      BuildPromptFromCoachParams(
        strategy: strategy,
        profile: params.profile.copyWith(
          targetLanguage: AppLanguage.ru,
        ),
        conversationGoal: goal,
        conversationContext: PromptConversationContext(
          recentTurns: recentForPrompt,
          sessionTopic: params.topic ?? strategy.suggestedTopic,
          sessionId: params.session.id,
        ),
        overrideMode: PromptMode.conversation,
        insightLines: insights,
        memorySummary: PromptMemorySummary(
          wordsToReview: strategy.wordsToReview,
          expressionsToPractice: strategy.expressionsToPractice,
          weakSkills: strategy.prioritySkillIds,
          insights: insights,
        ),
      ),
    );
    if (promptResult.isFailure) {
      return Err(promptResult.failureOrNull!);
    }
    final bundle = promptResult.valueOrNull!;

    final now = DateTime.now().toUtc();
    final userMessage = ConversationMessage(
      id: IdGenerator.v4(),
      sessionId: params.session.id,
      role: MessageRole.user,
      content: text,
      createdAt: now,
    );
    final savedUser = await _conversations.addMessage(userMessage);
    if (savedUser.isFailure) return Err(savedUser.failureOrNull!);

    final recentMessages = <String>[
      for (final message in history)
        if (message.role == MessageRole.coach)
          'coach: ${message.content}'
        else if (message.role == MessageRole.user)
          'user: ${message.content}',
    ];

    final aiResult = await _ai.generateCoachReply(
      AiCoachRequest(
        sessionId: params.session.id,
        mode: params.session.mode,
        targetLanguageCode: 'ru',
        nativeLanguageCode: params.profile.nativeLanguage.code,
        recentMessages: recentMessages,
        userUtterance: text,
        promptBundle: bundle,
      ),
    );
    if (aiResult.isFailure) return Err(aiResult.failureOrNull!);

    final coachMessage = ConversationMessage(
      id: IdGenerator.v4(),
      sessionId: params.session.id,
      role: MessageRole.coach,
      content: aiResult.valueOrNull!.content,
      createdAt: DateTime.now().toUtc(),
    );
    final savedCoach = await _conversations.addMessage(coachMessage);
    if (savedCoach.isFailure) return Err(savedCoach.failureOrNull!);

    return Success(
      SendCoachTurnResult(
        userMessage: savedUser.valueOrNull!,
        coachMessage: savedCoach.valueOrNull!,
      ),
    );
  }
}
