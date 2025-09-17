import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/debt_entity.dart';
import '../../domain/repositories/debt_repository.dart';
import '../datasources/local/debt_local_datasource.dart';
import '../models/debt_model.dart';

class DebtRepositoryImpl implements DebtRepository {
  final DebtLocalDataSource localDataSource;

  DebtRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<DebtEntity>>> getAllDebts() async {
    try {
      final result = await localDataSource.getAllDebts();
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to load debts'));
    }
  }

  @override
  Future<Either<Failure, DebtEntity>> getDebt(int id) async {
    try {
      final result = await localDataSource.getDebt(id);
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to get debt'));
    }
  }

  @override
  Future<Either<Failure, void>> insertDebt(DebtEntity debt) async {
    try {
      await localDataSource.insertDebt(DebtModel.fromEntity(debt));
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to insert debt'));
    }
  }

  @override
  Future<Either<Failure, void>> updateDebt(DebtEntity debt) async {
    try {
      await localDataSource.updateDebt(DebtModel.fromEntity(debt));
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to update debt'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDebt(int id) async {
    try {
      await localDataSource.deleteDebt(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to delete debt'));
    }
  }
}
