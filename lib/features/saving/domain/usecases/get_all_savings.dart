import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/saving_entity.dart';
import '../repositories/saving_repository.dart';

class GetAllSavings {
  final SavingRepository repository;
  GetAllSavings(this.repository);

  Future<Either<Failure, List<SavingEntity>>> execute() {
    return repository.getAllSavings();
  }
}