import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
  Future<Either<Failure, UserEntity>> getUser(int id);
  Future<Either<Failure, void>> insertUser(UserEntity user);
  Future<Either<Failure, void>> updateUser(UserEntity user);
  Future<Either<Failure, void>> deleteUser(int id);

  Future<Either<Failure, UserEntity>> getLastActiveUser();
}