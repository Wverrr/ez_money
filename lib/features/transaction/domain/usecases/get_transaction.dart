import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetTransaction {
  final TransactionRepository transactionRepository;

  GetTransaction(this.transactionRepository);

  Future<Either<Failure, TransactionEntity>> execute(int id) async {
    return await transactionRepository.getTransaction(id);
  }
}