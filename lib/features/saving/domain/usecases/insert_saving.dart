import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/saving_entity.dart';
import '../repositories/saving_repository.dart';

class InsertSaving {
  final SavingRepository repository;
  InsertSaving(this.repository);

  Future<Either<Failure, void>> execute(SavingEntity saving) {
    return repository.insertSaving(saving);
  }
}