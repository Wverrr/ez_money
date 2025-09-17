import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/saving_entity.dart';
import '../repositories/saving_repository.dart';

class GetSaving {
  final SavingRepository repository;
  GetSaving(this.repository);

  Future<Either<Failure, SavingEntity>> execute(int id) {
    return repository.getSaving(id);
  }
}