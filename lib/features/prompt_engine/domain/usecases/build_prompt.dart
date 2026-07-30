import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/prompt_bundle.dart';
import 'package:kompas/domain/entities/prompt_request.dart';
import 'package:kompas/services/prompt/prompt_engine_service.dart';

class BuildPromptParams {
  const BuildPromptParams({required this.request});
  final PromptRequest request;
}

class BuildPrompt extends UseCase<PromptBundle, BuildPromptParams> {
  BuildPrompt(this._engine);

  final PromptEngineService _engine;

  @override
  Future<Result<PromptBundle>> call(BuildPromptParams params) async {
    return _engine.buildPrompt(params.request);
  }
}
