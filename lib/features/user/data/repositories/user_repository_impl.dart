import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/user_local_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDatasource localDataSource;

  UserRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async{
    try {
      final result = await localDataSource.getAllUsers();
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to load users'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(int id) async{
    try {
      final result = await localDataSource.getUser(id);
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to load user'));
    }
  }

  @override
  Future<Either<Failure, void>> insertUser(UserEntity user) async{
    try {
      final result = await localDataSource.insertUser(UserModel.fromEntity(user));

      await localDataSource.saveLastActiveUser(result);
      return const Right(null);
    } catch (e) {
      log('Failed to insert user: $e');
      return Left(Failure('Failed to insert user'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity user) async{
    try {
      await localDataSource.updateUser(UserModel.fromEntity(user));
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to update user'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(int id) async{
    try {
      await localDataSource.deleteUser(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to delete user'));
    }
  }
  
  @override
  Future<Either<Failure, UserEntity>> getLastActiveUser() async{
    try {
      final id = await localDataSource.getLastActiveUser();
      final result = await localDataSource.getUser(id!);
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to load active user'));
    }
  }

}
