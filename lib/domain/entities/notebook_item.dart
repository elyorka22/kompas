import 'package:equatable/equatable.dart';
import 'package:kompas/domain/enums/memory_enums.dart';

/// Free-form learner capture. May link to an [Expression].
class NotebookItem extends Equatable {
  const NotebookItem({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    this.expressionId,
    this.sessionId,
    this.tags = const [],
    this.isPinned = false,
  });

  final String id;
  final String userId;
  final NotebookItemType type;
  final String title;
  final String body;
  final String? expressionId;
  final String? sessionId;
  final List<String> tags;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotebookItem copyWith({
    NotebookItemType? type,
    String? title,
    String? body,
    String? expressionId,
    String? sessionId,
    List<String>? tags,
    bool? isPinned,
    DateTime? updatedAt,
  }) {
    return NotebookItem(
      id: id,
      userId: userId,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      expressionId: expressionId ?? this.expressionId,
      sessionId: sessionId ?? this.sessionId,
      tags: tags ?? this.tags,
      isPinned: isPinned ?? this.isPinned,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        title,
        body,
        expressionId,
        sessionId,
        tags,
        isPinned,
        createdAt,
        updatedAt,
      ];
}
