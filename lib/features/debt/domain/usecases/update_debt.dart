import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/debt_entity.dart';
import '../repositories/debt_repository.dart';

class UpdateDebt {
  final DebtRepository repository;

  UpdateDebt(this.repository);

  Future<Either<Failure, void>> execute(DebtEntity debt) {
    return repository.updateDebt(debt);
  }
}