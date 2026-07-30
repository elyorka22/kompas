/// Conversation modes Prompt Engine can instruct an LLM to run.
///
/// Independent from Compass [PracticeMode]. Coach/Compass map into these.
enum PromptMode {
  conversation,
  storytelling,
  argumentation,
  vocabulary,
  explanation,
  roleplay,
  interview,
  debate,

  /// Reserved — Prompt Engine returns unsupported until enabled.
  pronunciation,

  /// Reserved — Prompt Engine returns unsupported until enabled.
  writing,
}

extension PromptModeX on PromptMode {
  bool get isFuture =>
      this == PromptMode.pronunciation || this == PromptMode.writing;

  String get displayName => switch (this) {
        PromptMode.conversation => 'Conversation',
        PromptMode.storytelling => 'Storytelling',
        PromptMode.argumentation => 'Argumentation',
        PromptMode.vocabulary => 'Vocabulary',
        PromptMode.explanation => 'Explanation',
        PromptMode.roleplay => 'Roleplay',
        PromptMode.interview => 'Interview',
        PromptMode.debate => 'Debate',
        PromptMode.pronunciation => 'Pronunciation',
        PromptMode.writing => 'Writing',
      };
}
