import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetAllTransactions {
  final TransactionRepository transactionRepository;
  GetAllTransactions(this.transactionRepository);
  Future<Either<Failure, List<TransactionEntity>>> execute(
    int year,
    int month,
    String searchQuery,
  ) async {
    return await transactionRepository.getAllTransactions(
      year,
      month,
      searchQuery,
    );
  }
}
