/// High-level speaking skill branches on the Skill Tree.
enum SkillCategory {
  conversation,
  argumentation,
  storytelling,
  vocabulary,
  descriptions,
  explanation,
  idioms,
  naturalSpeech,
  listening,
  pronunciation,
}

/// Unlock / mastery state of a skill node.
enum SkillStatus {
  locked,
  available,
  inProgress,
  mastered,
}
