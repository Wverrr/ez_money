import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/saving_entity.dart';

abstract class SavingRepository {
  Future<Either<Failure, List<SavingEntity>>> getAllSavings();
  Future<Either<Failure, SavingEntity>> getSaving(int id);
  Future<Either<Failure, void>> insertSaving(SavingEntity saving);
  Future<Either<Failure, void>> updateSaving(SavingEntity saving);
  Future<Either<Failure, void>> deleteSaving(int id);
}