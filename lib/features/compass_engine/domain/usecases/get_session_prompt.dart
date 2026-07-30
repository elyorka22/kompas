import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/enums/session_enums.dart';

class GetSessionPromptParams {
  const GetSessionPromptParams({required this.mode});
  final SessionMode mode;
}

/// Returns the local coach prompt for a practice mode.
class GetSessionPrompt extends UseCase<String, GetSessionPromptParams> {
  @override
  Future<Result<String>> call(GetSessionPromptParams params) async {
    final prompt = switch (params.mode) {
      SessionMode.freeTalk =>
        'Speak for a few minutes about your day. Focus on clarity, not perfection.',
      SessionMode.storytelling =>
        'Tell a short story with a beginning, middle, and end. Use past tense.',
      SessionMode.argumentation =>
        'Pick a position and defend it with two clear reasons.',
      SessionMode.explanation =>
        'Explain a familiar topic as if teaching a beginner.',
      SessionMode.speakingDrill =>
        'Repeat the target phrases aloud, then use each in your own sentence.',
      SessionMode.memoryReview =>
        'Recall each expression aloud before checking the answer.',
    };
    return Success(prompt);
  }
}
