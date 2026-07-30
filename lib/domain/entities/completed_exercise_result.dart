import 'package:equatable/equatable.dart';
import 'package:kompas/domain/entities/exercise.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';
import 'package:kompas/domain/entities/skill_progress.dart';

/// Result of completing one exercise through Compass Engine.
class CompletedExerciseResult extends Equatable {
  const CompletedExerciseResult({
    required this.exercise,
    required this.historyEntry,
    required this.updatedSkills,
  });

  final Exercise exercise;
  final ExerciseHistoryEntry historyEntry;
  final List<SkillProgress> updatedSkills;

  @override
  List<Object?> get props => [exercise, historyEntry, updatedSkills];
}
