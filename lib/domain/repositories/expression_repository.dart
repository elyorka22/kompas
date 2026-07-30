import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/expression.dart';

abstract class ExpressionRepository {
  Future<Result<Expression>> save(Expression expression);
  Future<Result<Expression>> getById(String id);
  Future<Result<List<Expression>>> listByUser(String userId);
  Future<Result<List<Expression>>> dueForReview({
    required String userId,
    required DateTime asOf,
    int limit = 20,
  });
  Future<Result<void>> delete(String id);
}
