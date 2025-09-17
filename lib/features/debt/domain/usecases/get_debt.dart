import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/debt_entity.dart';
import '../repositories/debt_repository.dart';

class GetDebt {
  final DebtRepository repository;
  GetDebt(this.repository);

  Future<Either<Failure, DebtEntity>> execute(int id) {
    return repository.getDebt(id);
  }

}