import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/debt_entity.dart';

abstract class DebtRepository {
  Future<Either<Failure, List<DebtEntity>>> getAllDebts();
  Future<Either<Failure, DebtEntity>> getDebt(int id);
  Future<Either<Failure, void>> insertDebt(DebtEntity debt);
  Future<Either<Failure, void>> updateDebt(DebtEntity debt);
  Future<Either<Failure, void>> deleteDebt(int id);
}
