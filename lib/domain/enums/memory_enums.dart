enum ExpressionSource {
  conversation,
  notebook,
  mission,
  manual,
  import,
}

/// Spaced-repetition interval state used by Memory Engine.
enum MemoryStrength {
  newItem,
  learning,
  reviewing,
  familiar,
  mastered,
}

enum NotebookItemType {
  expression,
  note,
  example,
  correction,
  idea,
}

/// Vocabulary Memory item kinds.
enum VocabularyKind {
  word,
  expression,
  idiom,
}

/// Discovered pattern categories (Apple Photos–style memories).
enum MemoryInsightKind {
  dominantPracticeMode,
  skillImprovement,
  neglectedSkill,
  preferredLearningTime,
  consistency,
  speakingTrend,
  favoriteTopic,
  weakSkillFocus,
  streakMomentum,
}

/// Preference keys stored by Memory Engine.
abstract final class MemoryPreferenceKeys {
  static const preferredPracticeMode = 'preferred_practice_mode';
  static const preferredLearningHour = 'preferred_learning_hour';
  static const currentLevel = 'current_level';
  static const learningGoal = 'learning_goal';
  static const avoidedTopics = 'avoided_topics';
}
