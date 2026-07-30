import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// Difficulty band for exercise rotation weighting.
enum ExerciseDifficulty {
  starter,
  core,
  stretch,
}

/// A concrete speaking task inside a practice mode.
///
/// Catalog is local/static. Compass Engine selects and rotates these offline.
class Exercise extends Equatable {
  const Exercise({
    required this.id,
    required this.code,
    required this.title,
    required this.prompt,
    required this.mode,
    required this.primarySkillId,
    required this.difficulty,
    this.secondarySkillIds = const [],
    this.coachHint,
    this.isActive = true,
  });

  final String id;
  final String code;
  final String title;
  final String prompt;
  final PracticeMode mode;
  final String primarySkillId;
  final List<String> secondarySkillIds;
  final ExerciseDifficulty difficulty;
  final String? coachHint;
  final bool isActive;

  @override
  List<Object?> get props => [
        id,
        code,
        title,
        prompt,
        mode,
        primarySkillId,
        secondarySkillIds,
        difficulty,
        coachHint,
        isActive,
      ];
}
