import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/saving_entity.dart';
import '../../domain/repositories/saving_repository.dart';
import '../datasources/local/saving_local_datasource.dart';
import '../models/saving_model.dart';

class SavingRepositoryImpl implements SavingRepository{
  final SavingLocalDatasource localDataSource;

  SavingRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<SavingEntity>>> getAllSavings() async{
    try {
      final savings = await localDataSource.getAllSavings();
      return Right(savings);
    } catch (e) {
      return Left(Failure('Failed to load savings'));
    }
  }

  @override
  Future<Either<Failure, SavingEntity>> getSaving(int id) async{
    try {
      final saving = await localDataSource.getSaving(id);
      return Right(saving);
    } catch (e) {
      return Left(Failure('Failed to load saving'));
    }
  }

  @override
  Future<Either<Failure, void>> insertSaving(SavingEntity saving) async{
    try {
      await localDataSource.insertSaving(SavingModel.fromEntity(saving));
      return Right(null);
    } catch (e) {
      return Left(Failure('Failed to insert saving'));
    }
  }

  @override
  Future<Either<Failure, void>> updateSaving(SavingEntity saving) async{
    try {
      await localDataSource.updateSaving(SavingModel.fromEntity(saving));
      return Right(null);
    } catch (e) {
      return Left(Failure('Failed to update saving'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSaving(int id) async{
    try {
      await localDataSource.deleteSaving(id);
      return Right(null);
    } catch (e) {
      return Left(Failure('Failed to delete saving'));
    }
  }

  
}