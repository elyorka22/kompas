import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/enums/memory_enums.dart';
import 'package:kompas/domain/repositories/expression_repository.dart';
import 'package:kompas/domain/repositories/statistics_repository.dart';
import 'package:kompas/services/progress/progress_calculator_service.dart';

class SaveExpressionParams {
  const SaveExpressionParams({
    required this.userId,
    required this.targetText,
    this.nativeText,
    this.contextExample,
    this.source = ExpressionSource.manual,
    this.tags = const [],
  });

  final String userId;
  final String targetText;
  final String? nativeText;
  final String? contextExample;
  final ExpressionSource source;
  final List<String> tags;
}

class SaveExpression extends UseCase<Expression, SaveExpressionParams> {
  SaveExpression({
    required ExpressionRepository expressionRepository,
    required StatisticsRepository statisticsRepository,
    required ProgressCalculatorService progressCalculator,
  })  : _expressions = expressionRepository,
        _statistics = statisticsRepository,
        _progress = progressCalculator;

  final ExpressionRepository _expressions;
  final StatisticsRepository _statistics;
  final ProgressCalculatorService _progress;

  @override
  Future<Result<Expression>> call(SaveExpressionParams params) async {
    final text = params.targetText.trim();
    if (text.isEmpty) {
      return const Err(ValidationFailure('Expression text is required'));
    }
    final now = DateTime.now().toUtc();
    final expression = Expression(
      id: IdGenerator.v4(),
      userId: params.userId,
      targetText: text,
      nativeText: params.nativeText?.trim(),
      contextExample: params.contextExample?.trim(),
      source: params.source,
      tags: params.tags,
      nextReviewAt: now,
      createdAt: now,
      updatedAt: now,
    );
    final saved = await _expressions.save(expression);
    if (saved.isFailure) return saved;

    final stats = await _statistics.getOrCreate(params.userId);
    if (stats.isSuccess) {
      await _statistics.save(
        _progress.afterExpressionSaved(stats.valueOrNull!),
      );
    }
    return saved;
  }
}
