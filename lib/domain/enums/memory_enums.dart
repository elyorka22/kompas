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
