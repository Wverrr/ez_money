import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getAllTransactions(int year, int month, String searchQuery);
  Future<Either<Failure, TransactionEntity>> getTransaction(int id);
  Future<Either<Failure, void>> insertTransaction(TransactionEntity transaction);
  Future<Either<Failure, void>> updateTransaction(TransactionEntity transaction);
  Future<Either<Failure, void>> deleteTransaction(int id);
}