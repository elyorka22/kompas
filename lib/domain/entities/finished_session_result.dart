import 'package:equatable/equatable.dart';
import 'package:kompas/domain/entities/conversation_session.dart';
import 'package:kompas/domain/entities/skill_progress.dart';
import 'package:kompas/domain/entities/user_statistics.dart';

/// Result of finishing a session through Compass Engine.
class FinishedSessionResult extends Equatable {
  const FinishedSessionResult({
    required this.session,
    required this.statistics,
    required this.updatedSkills,
    required this.streakDays,
  });

  final ConversationSession session;
  final UserStatistics statistics;
  final List<SkillProgress> updatedSkills;
  final int streakDays;

  @override
  List<Object?> get props => [session, statistics, updatedSkills, streakDays];
}
