import 'package:equatable/equatable.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/daily_mission.dart';
import 'package:kompas/domain/entities/daily_plan.dart';
import 'package:kompas/domain/entities/exercise_history_entry.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/entities/personal_learning_profile.dart';
import 'package:kompas/domain/entities/skill.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/domain/entities/user_statistics.dart';
import 'package:kompas/domain/enums/session_enums.dart';

/// Snapshot of everything Coach Engine needs to decide pedagogy.
///
/// Assembled from Compass Engine data, local Memory sources, and profile.
/// Memory Engine v1 (full) will enrich this snapshot later.
class LearnerContext extends Equatable {
  const LearnerContext({
    required this.userId,
    required this.profile,
    required this.skills,
    required this.skillProgress,
    required this.exerciseHistory,
    required this.recentSessions,
    required this.expressions,
    required this.statistics,
    required this.asOf,
    this.dailyPlan,
    this.todaysMissions = const [],
    this.favoriteModes = const [],
    this.avoidedTopics = const [],
    this.recentTopics = const [],
    this.preferredLearningHour,
  });

  final String userId;
  final PersonalLearningProfile profile;
  final List<Skill> skills;
  final List<SkillProgress> skillProgress;
  final List<ExerciseHistoryEntry> exerciseHistory;
  final List<ConversationSession> recentSessions;
  final List<Expression> expressions;
  final UserStatistics statistics;
  final DailyPlan? dailyPlan;
  final List<DailyMission> todaysMissions;
  final List<PracticeMode> favoriteModes;
  final List<String> avoidedTopics;
  final List<String> recentTopics;
  final int? preferredLearningHour;
  final DateTime asOf;

  Map<String, SkillProgress> get progressBySkillId => {
        for (final item in skillProgress) item.skillId: item,
      };

  @override
  List<Object?> get props => [
        userId,
        profile,
        skills,
        skillProgress,
        exerciseHistory,
        recentSessions,
        expressions,
        statistics,
        dailyPlan,
        todaysMissions,
        favoriteModes,
        avoidedTopics,
        recentTopics,
        preferredLearningHour,
        asOf,
      ];
}
