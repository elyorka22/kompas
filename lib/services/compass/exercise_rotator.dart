import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// Pure offline rotation / anti-repeat logic for Compass Engine.
///
/// Scoring priorities:
/// 1. Avoid exercises completed in the recent window
/// 2. Prefer focus skill / preferred mode
/// 3. Prefer modes not used recently
/// 4. Prefer starter → core → stretch as the learner advances
class ExerciseRotator {
  const ExerciseRotator({
    this.recentBlockSize = 5,
    this.modeCooldownSize = 3,
  });

  /// How many latest completions are hard-blocked from repeating.
  final int recentBlockSize;

  /// Modes among the last N completions get a soft penalty.
  final int modeCooldownSize;

  Exercise? recommend({
    required List<Exercise> candidates,
    required List<ExerciseHistoryEntry> historyNewestFirst,
    PracticeMode? preferredMode,
    String? focusSkillId,
    int Function(int max)? pickIndex,
  }) {
    final active = candidates.where((exercise) => exercise.isActive).toList();
    if (active.isEmpty) return null;

    final blockedIds = historyNewestFirst
        .take(recentBlockSize)
        .map((entry) => entry.exerciseId)
        .toSet();

    final recentModes = historyNewestFirst
        .take(modeCooldownSize)
        .map((entry) => entry.mode)
        .toSet();

    final scored = <({Exercise exercise, int score})>[];
    for (final exercise in active) {
      if (blockedIds.contains(exercise.id) && active.length > blockedIds.length) {
        continue;
      }

      var score = 100;
      if (preferredMode != null && exercise.mode == preferredMode) {
        score += 40;
      }
      if (focusSkillId != null && exercise.primarySkillId == focusSkillId) {
        score += 35;
      } else if (focusSkillId != null &&
          exercise.secondarySkillIds.contains(focusSkillId)) {
        score += 15;
      }
      if (recentModes.contains(exercise.mode)) {
        score -= 25;
      }
      if (blockedIds.contains(exercise.id)) {
        score -= 80;
      }
      score += switch (exercise.difficulty) {
        ExerciseDifficulty.starter => 8,
        ExerciseDifficulty.core => 4,
        ExerciseDifficulty.stretch => 0,
      };
      scored.add((exercise: exercise, score: score));
    }

    if (scored.isEmpty) {
      return active.first;
    }

    scored.sort((a, b) => b.score.compareTo(a.score));
    final bestScore = scored.first.score;
    final top = scored.where((item) => item.score == bestScore).toList();
    if (top.length == 1 || pickIndex == null) {
      return top.first.exercise;
    }
    final index = pickIndex(top.length).clamp(0, top.length - 1);
    return top[index].exercise;
  }
}
