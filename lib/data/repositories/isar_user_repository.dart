import 'package:isar/isar.dart';
import 'package:kompas/core/errors/failures.dart';
import 'package:kompas/core/errors/result.dart';
import 'package:kompas/data/local/collections/user_collection.dart';
import 'package:kompas/data/local/mappers/entity_mappers.dart';
import 'package:kompas/domain/entities/user.dart';
import 'package:kompas/domain/repositories/user_repository.dart';

class IsarUserRepository implements UserRepository {
  IsarUserRepository(this._isar);

  final Isar _isar;

  @override
  Future<Result<User?>> getActiveUser() async {
    try {
      final collection = await _isar.userCollections.where().findFirst();
      if (collection == null) return const Success(null);
      return Success(EntityMappers.toUser(collection));
    } catch (error) {
      return Err(StorageFailure('Failed to load active user', cause: error));
    }
  }

  @override
  Future<Result<User>> getById(String id) async {
    try {
      final collection = await _isar.userCollections
          .filter()
          .domainIdEqualTo(id)
          .findFirst();
      if (collection == null) {
        return const Err(NotFoundFailure('User not found'));
      }
      return Success(EntityMappers.toUser(collection));
    } catch (error) {
      return Err(StorageFailure('Failed to load user', cause: error));
    }
  }

  @override
  Future<Result<User>> save(User user) async {
    try {
      final existing = await _isar.userCollections
          .filter()
          .domainIdEqualTo(user.id)
          .findFirst();
      final mapped = EntityMappers.fromUser(user, isarId: existing?.id);
      await _isar.writeTxn(() async {
        await _isar.userCollections.put(mapped);
      });
      return Success(user);
    } catch (error) {
      return Err(StorageFailure('Failed to save user', cause: error));
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.userCollections.filter().domainIdEqualTo(id).deleteAll();
      });
      return const Success(null);
    } catch (error) {
      return Err(StorageFailure('Failed to delete user', cause: error));
    }
  }
}
