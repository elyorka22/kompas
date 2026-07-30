import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/core/utils/id_generator.dart';
import 'package:kompas/domain/entities/notebook_item.dart';
import 'package:kompas/domain/enums/memory_enums.dart';
import 'package:kompas/domain/repositories/notebook_repository.dart';

class SaveNotebookItemParams {
  const SaveNotebookItemParams({
    required this.userId,
    required this.title,
    required this.body,
    this.type = NotebookItemType.note,
    this.expressionId,
    this.sessionId,
    this.tags = const [],
  });

  final String userId;
  final String title;
  final String body;
  final NotebookItemType type;
  final String? expressionId;
  final String? sessionId;
  final List<String> tags;
}

class SaveNotebookItem extends UseCase<NotebookItem, SaveNotebookItemParams> {
  SaveNotebookItem(this._notebook);

  final NotebookRepository _notebook;

  @override
  Future<Result<NotebookItem>> call(SaveNotebookItemParams params) async {
    if (params.title.trim().isEmpty && params.body.trim().isEmpty) {
      return const Err(ValidationFailure('Notebook item cannot be empty'));
    }
    final now = DateTime.now().toUtc();
    final item = NotebookItem(
      id: IdGenerator.v4(),
      userId: params.userId,
      type: params.type,
      title: params.title.trim().isEmpty ? 'Untitled' : params.title.trim(),
      body: params.body.trim(),
      expressionId: params.expressionId,
      sessionId: params.sessionId,
      tags: params.tags,
      createdAt: now,
      updatedAt: now,
    );
    return _notebook.save(item);
  }
}
