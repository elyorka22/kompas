import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/enums/memory_enums.dart';

/// Spaced-repetition engine for expressions.
///
/// Uses a simplified SM-2 style schedule. Pure domain math — no I/O.
class MemoryEngineService {
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
      _ => (expression.intervalDays * expression.easeFactor).round().clamp(4, 180),
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

  double _nextEase(double current, int quality) {
    final next = current + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
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
