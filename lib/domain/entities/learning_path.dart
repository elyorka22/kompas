import 'package:equatable/equatable.dart';

/// Ordered curriculum spine. Skill Tree nodes hang off a path.
class LearningPath extends Equatable {
  const LearningPath({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.skillIds,
    this.isDefault = false,
  });

  final String id;
  final String code;
  final String title;
  final String description;
  final List<String> skillIds;
  final bool isDefault;

  @override
  List<Object?> get props => [
        id,
        code,
        title,
        description,
        skillIds,
        isDefault,
      ];
}

/// Active path assignment for a user.
class UserLearningPath extends Equatable {
  const UserLearningPath({
    required this.id,
    required this.userId,
    required this.learningPathId,
    required this.startedAt,
    this.currentSkillId,
  });

  final String id;
  final String userId;
  final String learningPathId;
  final String? currentSkillId;
  final DateTime startedAt;

  UserLearningPath copyWith({
    String? currentSkillId,
  }) {
    return UserLearningPath(
      id: id,
      userId: userId,
      learningPathId: learningPathId,
      currentSkillId: currentSkillId ?? this.currentSkillId,
      startedAt: startedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        learningPathId,
        currentSkillId,
        startedAt,
      ];
}
