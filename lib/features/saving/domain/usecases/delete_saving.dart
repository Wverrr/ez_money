import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/saving_repository.dart';

class DeleteSaving {
  final SavingRepository repository;
  DeleteSaving(this.repository);

  Future<Either<Failure, void>> execute(int id) {
    return repository.deleteSaving(id);
  }
}