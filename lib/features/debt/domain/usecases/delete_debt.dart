import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/debt_repository.dart';

class DeleteDebt {
  final DebtRepository repository;

  DeleteDebt(this.repository);

  Future<Either<Failure, void>> execute(int id) {
    return repository.deleteDebt(id);
  }
}