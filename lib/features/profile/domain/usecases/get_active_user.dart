import 'package:kompas/core/errors/result.dart';
import 'package:kompas/core/usecase/use_case.dart';
import 'package:kompas/domain/entities/user.dart';
import 'package:kompas/domain/repositories/user_repository.dart';

class GetActiveUser extends UseCase<User?, NoParams> {
  GetActiveUser(this._users);

  final UserRepository _users;

  @override
  Future<Result<User?>> call(NoParams params) {
    return _users.getActiveUser();
  }
}
