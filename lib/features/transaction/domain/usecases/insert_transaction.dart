import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class InsertTransaction {
  final TransactionRepository transactionRepository;

  InsertTransaction(this.transactionRepository);
  Future<Either<Failure, void>> execute(TransactionEntity transaction) async{
    return await transactionRepository.insertTransaction(transaction);
  }

}