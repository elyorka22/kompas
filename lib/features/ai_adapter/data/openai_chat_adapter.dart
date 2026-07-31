import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/features/ai_adapter/domain/ai_adapter.dart';

/// OpenAI Chat Completions adapter.
///
/// Maps [PromptBundle] + conversation history into provider messages.
/// Never invents pedagogy — Prompt Engine owns prompts.
class OpenAiChatAdapter implements AiAdapter {
  OpenAiChatAdapter({
    required this.apiKey,
    this.model = 'gpt-4o-mini',
    this.baseUrl = 'https://api.openai.com/v1',
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String apiKey;
  final String model;
  final String baseUrl;
  final http.Client _client;

  @override
  bool get isAvailable => apiKey.trim().isNotEmpty;

  @override
  Future<Result<AiCoachReply>> generateCoachReply(
    AiCoachRequest request,
  ) async {
    if (!isAvailable) {
      return const Err(
        UnsupportedFailure('OpenAI API key is missing.'),
      );
    }

    try {
      final messages = _buildMessages(request);
      final uri = Uri.parse('$baseUrl/chat/completions');
      final response = await _client.post(
        uri,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': model,
          'temperature': 0.7,
          'messages': messages,
        }),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return Err(
          NetworkFailure(
            'OpenAI error ${response.statusCode}: ${response.body}',
          ),
        );
      }

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      final choices = decoded['choices'] as List<dynamic>?;
      if (choices == null || choices.isEmpty) {
        return const Err(NetworkFailure('OpenAI returned no choices.'));
      }
      final message = choices.first['message'] as Map<String, dynamic>?;
      final content = (message?['content'] as String?)?.trim() ?? '';
      if (content.isEmpty) {
        return const Err(NetworkFailure('OpenAI returned empty content.'));
      }
      return Success(AiCoachReply(content: content));
    } catch (error) {
      return Err(NetworkFailure('OpenAI request failed', cause: error));
    }
  }

  @override
  Future<Result<List<String>>> suggestExpressions({
    required String transcript,
    required String targetLanguageCode,
  }) async {
    final reply = await generateCoachReply(
      AiCoachRequest(
        sessionId: 'suggest',
        mode: PracticeMode.explainWord,
        targetLanguageCode: targetLanguageCode,
        nativeLanguageCode: 'ru',
        recentMessages: const [],
        userUtterance: transcript,
        systemPrompt:
            'Extract 1-3 useful Russian expressions from the learner text. '
            'Reply as a plain bullet list only.',
      ),
    );
    return reply.map((value) {
      return value.content
          .split('\n')
          .map((line) => line.replaceFirst(RegExp(r'^[-•*\d.\s]+'), '').trim())
          .where((line) => line.isNotEmpty)
          .take(3)
          .toList();
    });
  }

  List<Map<String, String>> _buildMessages(AiCoachRequest request) {
    final messages = <Map<String, String>>[];
    final system = request.promptBundle?.systemPrompt ??
        request.systemPrompt ??
        '';
    final developer = request.promptBundle?.developerPrompt ??
        request.developerPrompt ??
        '';

    if (system.isNotEmpty) {
      messages.add({'role': 'system', 'content': system});
    }
    if (developer.isNotEmpty) {
      messages.add({
        'role': 'system',
        'content': 'Developer instructions:\n$developer',
      });
    }

    messages.add({
      'role': 'system',
      'content':
          'You are Компас — a Russian conversation coach, not a generic assistant. '
          'Speak mostly in Russian. Keep turns short. Ask follow-up questions. '
          'Correct naturally without long lectures. Push the learner to speak longer.',
    });

    for (final turn in request.recentMessages) {
      final trimmed = turn.trim();
      if (trimmed.isEmpty) continue;
      if (trimmed.startsWith('coach:')) {
        messages.add({
          'role': 'assistant',
          'content': trimmed.substring(6).trim(),
        });
      } else if (trimmed.startsWith('user:')) {
        messages.add({
          'role': 'user',
          'content': trimmed.substring(5).trim(),
        });
      } else {
        messages.add({'role': 'user', 'content': trimmed});
      }
    }

    final utterance = request.userUtterance?.trim();
    if (utterance != null && utterance.isNotEmpty) {
      messages.add({'role': 'user', 'content': utterance});
    }

    return messages;
  }
}
