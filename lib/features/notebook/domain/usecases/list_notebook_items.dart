import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/notebook_item.dart';
import 'package:kompas/domain/repositories/notebook_repository.dart';

class ListNotebookItemsParams {
  const ListNotebookItemsParams({required this.userId});
  final String userId;
}

class ListNotebookItems
    extends UseCase<List<NotebookItem>, ListNotebookItemsParams> {
  ListNotebookItems(this._notebook);

  final NotebookRepository _notebook;

  @override
  Future<Result<List<NotebookItem>>> call(ListNotebookItemsParams params) {
    return _notebook.listByUser(params.userId);
  }
}
