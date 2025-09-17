
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/estimation_entity.dart';
import '../repositories/estimation_repository.dart';

class EstimateExpense {
  final EstimationRepository repository;
  EstimateExpense(this.repository);

  Future<Either<Failure, EstimationResponseEntity>> execute(EstimationRequestEntity request) => repository.estimate(request);
}