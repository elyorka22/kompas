import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/app_language.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// Aggregated personal learning identity remembered by Memory Engine.
class PersonalLearningProfile extends Equatable {
  const PersonalLearningProfile({
    required this.id,
    required this.userId,
    required this.nativeLanguage,
    required this.targetLanguage,
    required this.updatedAt,
    this.displayName = '',
    this.currentLevel = 'A2',
    this.learningGoal,
    this.preferredPracticeMode,
    this.weakestSkillIds = const [],
    this.strongestSkillIds = const [],
    this.favoriteTopicIds = const [],
  });

  final String id;
  final String userId;
  final String displayName;
  final AppLanguage nativeLanguage;
  final AppLanguage targetLanguage;
  final String currentLevel;
  final String? learningGoal;
  final PracticeMode? preferredPracticeMode;
  final List<String> weakestSkillIds;
  final List<String> strongestSkillIds;
  final List<String> favoriteTopicIds;
  final DateTime updatedAt;

  PersonalLearningProfile copyWith({
    String? displayName,
    AppLanguage? nativeLanguage,
    AppLanguage? targetLanguage,
    String? currentLevel,
    String? learningGoal,
    PracticeMode? preferredPracticeMode,
    List<String>? weakestSkillIds,
    List<String>? strongestSkillIds,
    List<String>? favoriteTopicIds,
    DateTime? updatedAt,
  }) {
    return PersonalLearningProfile(
      id: id,
      userId: userId,
      displayName: displayName ?? this.displayName,
      nativeLanguage: nativeLanguage ?? this.nativeLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      currentLevel: currentLevel ?? this.currentLevel,
      learningGoal: learningGoal ?? this.learningGoal,
      preferredPracticeMode:
          preferredPracticeMode ?? this.preferredPracticeMode,
      weakestSkillIds: weakestSkillIds ?? this.weakestSkillIds,
      strongestSkillIds: strongestSkillIds ?? this.strongestSkillIds,
      favoriteTopicIds: favoriteTopicIds ?? this.favoriteTopicIds,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        displayName,
        nativeLanguage,
        targetLanguage,
        currentLevel,
        learningGoal,
        preferredPracticeMode,
        weakestSkillIds,
        strongestSkillIds,
        favoriteTopicIds,
        updatedAt,
      ];
}
