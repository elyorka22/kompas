import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/notebook_item.dart';

abstract class NotebookRepository {
  Future<Result<NotebookItem>> save(NotebookItem item);
  Future<Result<NotebookItem>> getById(String id);
  Future<Result<List<NotebookItem>>> listByUser(
    String userId, {
    bool pinnedFirst = true,
  });
  Future<Result<void>> delete(String id);
}
