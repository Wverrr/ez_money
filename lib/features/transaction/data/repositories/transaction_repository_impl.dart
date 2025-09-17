import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/local/transaction_local_datasource.dart';
import '../models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource localDataSource;

  TransactionRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions() async {
    try {
      final result = await localDataSource.getAllTransactions();
      final entities = result.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(Failure('Failed to load transactions'));
    }
  }

  // @override
  // Future<Either<Failure, List<TransactionWithRelationsModel>>> getAllTransactions() async {
  //   try {
  //     final result = await localDataSource.getAllTransactions();
  //     return Right(result);
  //   } catch (e) {
  //     return Left(Failure('Failed to load transactions'));
  //   }
  // }

  @override
  Future<Either<Failure, TransactionEntity>> getTransaction(int id) async {
    try {
      final result = await localDataSource.getTransaction(id);
      return Right(result);
    } catch (e) {
      return Left(Failure('Failed to load transaction'));
    }
  }

  @override
  Future<Either<Failure, void>> insertTransaction(TransactionEntity transaction) async {
    try {
      await localDataSource.insertTransaction(TransactionModel.fromEntity(transaction));
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to insert transaction'));
    }
  }

  @override
  Future<Either<Failure, void>> updateTransaction(TransactionEntity transaction) async {
    try {
      await localDataSource.updateTransaction(TransactionModel.fromEntity(transaction));
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to update transaction'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(int id) async {
    try {
      await localDataSource.deleteTransaction(id);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to delete transaction'));
    }
  }
}
