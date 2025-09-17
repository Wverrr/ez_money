import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class UpdateTransaction {
  final TransactionRepository repository;
  UpdateTransaction(this.repository);

  Future<Either<Failure, void>> execute(TransactionEntity transaction) async {
    return await repository.updateTransaction(transaction);
  }
}