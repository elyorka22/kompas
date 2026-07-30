/// Practice modes owned by Compass Engine v1.
///
/// Each mode maps to one or more Skill Tree nodes and a pool of exercises.
enum PracticeMode {
  /// Explain a word — definition, examples, usage.
  explainWord,

  /// Continue a story from a given opening.
  continueStory,

  /// Describe an image (placeholder media in v1).
  describeImage,

  /// Tell about your day — natural conversation.
  tellAboutDay,

  /// Defend your opinion with reasons.
  defendOpinion,

  /// Retell a short text in your own words.
  retellText,

  /// Explain an idiom with meaning and example.
  explainIdiom,
}

/// Lifecycle of a conversation session.
enum SessionStatus {
  draft,
  active,
  paused,
  completed,
  abandoned,
}

/// Who produced a message inside a session.
enum MessageRole {
  user,
  coach,
  system,
}
