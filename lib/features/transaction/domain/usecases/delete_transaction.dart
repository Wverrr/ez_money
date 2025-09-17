import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/transaction_repository.dart';

class DeleteTransaction {
  final TransactionRepository repository;
  DeleteTransaction(this.repository);

  Future<Either<Failure, void>> execute(int id) async {
    return await repository.deleteTransaction(id);
  }
}