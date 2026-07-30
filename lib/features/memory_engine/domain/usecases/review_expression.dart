import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/enums/memory_enums.dart';
import 'package:kompas/domain/repositories/expression_repository.dart';
import 'package:kompas/domain/repositories/statistics_repository.dart';
import 'package:kompas/services/memory/memory_engine_service.dart';
import 'package:kompas/services/progress/progress_calculator_service.dart';

class ReviewExpressionParams {
  const ReviewExpressionParams({
    required this.expression,
    required this.quality,
  });

  final Expression expression;
  final int quality;
}

class ReviewExpression extends UseCase<Expression, ReviewExpressionParams> {
  ReviewExpression({
    required ExpressionRepository expressionRepository,
    required MemoryEngineService memoryEngine,
    required StatisticsRepository statisticsRepository,
    required ProgressCalculatorService progressCalculator,
  })  : _expressions = expressionRepository,
        _memory = memoryEngine,
        _statistics = statisticsRepository,
        _progress = progressCalculator;

  final ExpressionRepository _expressions;
  final MemoryEngineService _memory;
  final StatisticsRepository _statistics;
  final ProgressCalculatorService _progress;

  @override
  Future<Result<Expression>> call(ReviewExpressionParams params) async {
    final previous = params.expression.strength;
    final updated = _memory.review(params.expression, quality: params.quality);
    final saved = await _expressions.save(updated);
    if (saved.isFailure) return saved;

    if (previous != MemoryStrength.mastered &&
        updated.strength == MemoryStrength.mastered) {
      final stats = await _statistics.getOrCreate(updated.userId);
      if (stats.isSuccess) {
        await _statistics.save(
          _progress.afterExpressionMastered(stats.valueOrNull!),
        );
      }
    }
    return saved;
  }
}
