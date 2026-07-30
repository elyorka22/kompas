import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/expression_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/expression.dart';
import 'package:kompas/domain/repositories/expression_repository.dart';

class IsarExpressionRepository implements ExpressionRepository {
  IsarExpressionRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<Expression>> save(Expression expression) async {
    try {
      final existing = await _isar.expressionCollections
          .filter()
          .domainIdEqualTo(expression.id)
          .findFirst();
      final mapped =
          EntityMappers.fromExpression(expression, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.expressionCollections.put(mapped);
      });
      return Success(expression);
    } catch (error) {
      return Err(StorageFailure('Failed to save expression', cause: error));
    }
  }

  @override
  Future<Result<Expression>> getById(String id) async {
    try {
      final collection = await _isar.expressionCollections
          .filter()
          .domainIdEqualTo(id)
          .findFirst();
      if (collection == null) {
        return const Err(NotFoundFailure('Expression not found'));
      }
      return Success(EntityMappers.toExpression(collection));
    } catch (error) {
      return Err(StorageFailure('Failed to load expression', cause: error));
    }
  }

  @override
  Future<Result<List<Expression>>> listByUser(String userId) async {
    try {
      final items = await _isar.expressionCollections
          .filter()
          .userIdEqualTo(userId)
          .sortByUpdatedAtDesc()
          .findAll();
      return Success(items.map(EntityMappers.toExpression).toList());
    } catch (error) {
      return Err(StorageFailure('Failed to list expressions', cause: error));
    }
  }

  @override
  Future<Result<List<Expression>>> dueForReview({
    required String userId,
    required DateTime asOf,
    int limit = 20,
  }) async {
    try {
      final items = await _isar.expressionCollections
          .filter()
          .userIdEqualTo(userId)
          .findAll();
      final due = items
          .where(
            (item) =>
                item.nextReviewAt == null ||
                !item.nextReviewAt!.isAfter(asOf),
          )
          .take(limit)
          .map(EntityMappers.toExpression)
          .toList();
      return Success(due);
    } catch (error) {
      return Err(
        StorageFailure('Failed to load due expressions', cause: error),
      );
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.expressionCollections
            .filter()
            .domainIdEqualTo(id)
            .deleteAll();
      });
      return const Success(null);
    } catch (error) {
      return Err(StorageFailure('Failed to delete expression', cause: error));
    }
  }
}
