import 'package:equatable/equatable.dart';

/// Aggregated learner metrics computed offline from local activity.
class UserStatistics extends Equatable {
  const UserStatistics({
    required this.id,
    required this.userId,
    required this.updatedAt,
    this.totalSpeakingSeconds = 0,
    this.totalSessions = 0,
    this.completedSessions = 0,
    this.expressionsSaved = 0,
    this.expressionsMastered = 0,
    this.missionsCompleted = 0,
    this.currentStreakDays = 0,
    this.longestStreakDays = 0,
    this.skillsMastered = 0,
    this.achievementsUnlocked = 0,
    this.lastPracticeAt,
  });

  final String id;
  final String userId;
  final int totalSpeakingSeconds;
  final int totalSessions;
  final int completedSessions;
  final int expressionsSaved;
  final int expressionsMastered;
  final int missionsCompleted;
  final int currentStreakDays;
  final int longestStreakDays;
  final int skillsMastered;
  final int achievementsUnlocked;
  final DateTime? lastPracticeAt;
  final DateTime updatedAt;

  int get totalSpeakingMinutes => totalSpeakingSeconds ~/ 60;

  UserStatistics copyWith({
    int? totalSpeakingSeconds,
    int? totalSessions,
    int? completedSessions,
    int? expressionsSaved,
    int? expressionsMastered,
    int? missionsCompleted,
    int? currentStreakDays,
    int? longestStreakDays,
    int? skillsMastered,
    int? achievementsUnlocked,
    DateTime? lastPracticeAt,
    DateTime? updatedAt,
  }) {
    return UserStatistics(
      id: id,
      userId: userId,
      totalSpeakingSeconds:
          totalSpeakingSeconds ?? this.totalSpeakingSeconds,
      totalSessions: totalSessions ?? this.totalSessions,
      completedSessions: completedSessions ?? this.completedSessions,
      expressionsSaved: expressionsSaved ?? this.expressionsSaved,
      expressionsMastered: expressionsMastered ?? this.expressionsMastered,
      missionsCompleted: missionsCompleted ?? this.missionsCompleted,
      currentStreakDays: currentStreakDays ?? this.currentStreakDays,
      longestStreakDays: longestStreakDays ?? this.longestStreakDays,
      skillsMastered: skillsMastered ?? this.skillsMastered,
      achievementsUnlocked:
          achievementsUnlocked ?? this.achievementsUnlocked,
      lastPracticeAt: lastPracticeAt ?? this.lastPracticeAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        totalSpeakingSeconds,
        totalSessions,
        completedSessions,
        expressionsSaved,
        expressionsMastered,
        missionsCompleted,
        currentStreakDays,
        longestStreakDays,
        skillsMastered,
        achievementsUnlocked,
        lastPracticeAt,
        updatedAt,
      ];
}
