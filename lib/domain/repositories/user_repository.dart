import 'package:kompas/core/errors/result.dart';
import 'package:kompas/domain/entities/user.dart';

abstract class UserRepository {
  Future<Result<User?>> getActiveUser();
  Future<Result<User>> getById(String id);
  Future<Result<User>> save(User user);
  Future<Result<void>> delete(String id);
}
