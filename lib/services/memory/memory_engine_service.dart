import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/enums/memory_enums.dart';
import 'package:kompas/domain/repositories/expression_repository.dart';
import 'package:kompas/domain/repositories/statistics_repository.dart';
import 'package:kompas/services/progress/progress_calculator_service.dart';

/// Memory Engine — remembers expressions and produces offline insights.
///
/// SM-2 math stays pure. Persistence goes through repositories.
class MemoryEngineService {
  MemoryEngineService({
    ExpressionRepository? expressionRepository,
    StatisticsRepository? statisticsRepository,
    ProgressCalculatorService? progressCalculator,
  })  : _expressions = expressionRepository,
        _statistics = statisticsRepository,
        _progress = progressCalculator ?? ProgressCalculatorService();

  final ExpressionRepository? _expressions;
  final StatisticsRepository? _statistics;
  final ProgressCalculatorService _progress;

  /// quality: 0 (forgot) … 5 (perfect recall).
  Expression review(Expression expression, {required int quality}) {
    final q = quality.clamp(0, 5);
    final now = DateTime.now().toUtc();

    if (q < 3) {
      return expression.copyWith(
        repetitions: 0,
        intervalDays: 0,
        strength: MemoryStrength.learning,
        easeFactor: _nextEase(expression.easeFactor, q),
        lastReviewedAt: now,
        nextReviewAt: now.add(const Duration(minutes: 10)),
        updatedAt: now,
      );
    }

    final repetitions = expression.repetitions + 1;
    final interval = switch (repetitions) {
      1 => 1,
      2 => 3,
      _ =>
        (expression.intervalDays * expression.easeFactor).round().clamp(4, 180),
    };
    final ease = _nextEase(expression.easeFactor, q);
    final strength = _strengthFor(repetitions, interval);

    return expression.copyWith(
      repetitions: repetitions,
      intervalDays: interval,
      easeFactor: ease,
      strength: strength,
      lastReviewedAt: now,
      nextReviewAt: now.add(Duration(days: interval)),
      updatedAt: now,
    );
  }

  /// Persist a phrase practiced during a local session.
  Future<Result<Expression>> rememberPracticePhrase({
    required String userId,
    required String targetText,
    String? contextExample,
    List<String> tags = const [],
  }) async {
    final repo = _expressions;
    if (repo == null) {
      return const Err(UnsupportedFailure('Expression repository unavailable'));
    }
    final text = targetText.trim();
    if (text.isEmpty) {
      return const Err(ValidationFailure('Practice phrase is required'));
    }

    final now = DateTime.now().toUtc();
    final expression = Expression(
      id: IdGenerator.v4(),
      userId: userId,
      targetText: text,
      contextExample: contextExample?.trim(),
      source: ExpressionSource.conversation,
      tags: tags,
      strength: MemoryStrength.learning,
      nextReviewAt: now.add(const Duration(hours: 4)),
      createdAt: now,
      updatedAt: now,
    );

    final saved = await repo.save(expression);
    if (saved.isFailure) return saved;

    final statsRepo = _statistics;
    if (statsRepo != null) {
      final stats = await statsRepo.getOrCreate(userId);
      if (stats.isSuccess) {
        await statsRepo.save(_progress.afterExpressionSaved(stats.valueOrNull!));
      }
    }
    return saved;
  }

  Future<Result<List<Expression>>> dueForReview({
    required String userId,
    int limit = 8,
  }) async {
    final repo = _expressions;
    if (repo == null) {
      return const Err(UnsupportedFailure('Expression repository unavailable'));
    }
    return repo.dueForReview(
      userId: userId,
      asOf: DateTime.now().toUtc(),
      limit: limit,
    );
  }

  Future<Result<List<String>>> buildInsights({required String userId}) async {
    final repo = _expressions;
    if (repo == null) {
      return const Success(<String>[]);
    }

    final all = await repo.listByUser(userId);
    if (all.isFailure) return Err(all.failureOrNull!);
    final items = all.valueOrNull ?? const <Expression>[];
    if (items.isEmpty) {
      return const Success([
        'Your notebook is ready. Save phrases from practice to build memory.',
      ]);
    }

    final due = items.where((e) => e.needsReview).length;
    final mastered = items.where((e) => e.isMastered).length;
    final learning = items
        .where(
          (e) =>
              e.strength == MemoryStrength.learning ||
              e.strength == MemoryStrength.newItem,
        )
        .length;

    final insights = <String>[
      'You are tracking ${items.length} expression${items.length == 1 ? '' : 's'}.',
      if (due > 0) '$due ready for review today.',
      if (mastered > 0) '$mastered mastered — keep recycling them in speech.',
      if (learning > 0) '$learning still settling into long-term memory.',
    ];
    return Success(insights);
  }

  double _nextEase(double current, int quality) {
    final next =
        current + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (next < 1.3) return 1.3;
    return next;
  }

  MemoryStrength _strengthFor(int repetitions, int intervalDays) {
    if (repetitions <= 1) return MemoryStrength.learning;
    if (intervalDays < 7) return MemoryStrength.reviewing;
    if (intervalDays < 30) return MemoryStrength.familiar;
    return MemoryStrength.mastered;
  }
}
