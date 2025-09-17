import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/saving_entity.dart';
import '../repositories/saving_repository.dart';

class UpdateSaving {
  final SavingRepository repository;
  UpdateSaving(this.repository);

  Future<Either<Failure, void>> execute(SavingEntity saving) {
    return repository.updateSaving(saving);
  }
}