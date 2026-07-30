import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/enums/session_enums.dart';
import 'package:kompas/services/compass/practice_mode_catalog.dart';

class GetSessionPromptParams {
  const GetSessionPromptParams({required this.mode});
  final PracticeMode mode;
}

/// Returns the local coach prompt for a practice mode.
class GetSessionPrompt extends UseCase<String, GetSessionPromptParams> {
  @override
  Future<Result<String>> call(GetSessionPromptParams params) async {
    return Success(PracticeModeCatalog.defaultPrompt(params.mode));
  }
}
