/// Modes that shape how a conversation session is coached.
enum SessionMode {
  /// Free speaking with light coaching prompts.
  freeTalk,

  /// Guided storytelling with structure cues.
  storytelling,

  /// Argument construction and rebuttal practice.
  argumentation,

  /// Explanation / teach-back practice.
  explanation,

  /// Scripted speaking drill without AI dialogue.
  speakingDrill,

  /// Spaced-repetition expression review aloud.
  memoryReview,
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
