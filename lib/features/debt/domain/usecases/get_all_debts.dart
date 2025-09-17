import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/debt_entity.dart';
import '../repositories/debt_repository.dart';

class GetAllDebts {
  final DebtRepository repository;
  GetAllDebts(this.repository);

  Future<Either<Failure, List<DebtEntity>>> execute() {
    return repository.getAllDebts();
  }

}