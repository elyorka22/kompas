import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/notebook_item_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/notebook_item.dart';
import 'package:kompas/domain/repositories/notebook_repository.dart';

class IsarNotebookRepository implements NotebookRepository {
  IsarNotebookRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<NotebookItem>> save(NotebookItem item) async {
    try {
      final existing = await _isar.notebookItemCollections
          .filter()
          .domainIdEqualTo(item.id)
          .findFirst();
      final mapped =
          EntityMappers.fromNotebookItem(item, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.notebookItemCollections.put(mapped);
      });
      return Success(item);
    } catch (error) {
      return Err(StorageFailure('Failed to save notebook item', cause: error));
    }
  }

  @override
  Future<Result<NotebookItem>> getById(String id) async {
    try {
      final collection = await _isar.notebookItemCollections
          .filter()
          .domainIdEqualTo(id)
          .findFirst();
      if (collection == null) {
        return const Err(NotFoundFailure('Notebook item not found'));
      }
      return Success(EntityMappers.toNotebookItem(collection));
    } catch (error) {
      return Err(StorageFailure('Failed to load notebook item', cause: error));
    }
  }

  @override
  Future<Result<List<NotebookItem>>> listByUser(
    String userId, {
    bool pinnedFirst = true,
  }) async {
    try {
      final items = await _isar.notebookItemCollections
          .filter()
          .userIdEqualTo(userId)
          .sortByUpdatedAtDesc()
          .findAll();
      final mapped = items.map(EntityMappers.toNotebookItem).toList();
      if (pinnedFirst) {
        mapped.sort((a, b) {
          if (a.isPinned == b.isPinned) {
            return b.updatedAt.compareTo(a.updatedAt);
          }
          return a.isPinned ? -1 : 1;
        });
      }
      return Success(mapped);
    } catch (error) {
      return Err(StorageFailure('Failed to list notebook', cause: error));
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.notebookItemCollections
            .filter()
            .domainIdEqualTo(id)
            .deleteAll();
      });
      return const Success(null);
    } catch (error) {
      return Err(
        StorageFailure('Failed to delete notebook item', cause: error),
      );
    }
  }
}
