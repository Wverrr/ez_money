import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/estimation_entity.dart';
import '../entities/train_record_entity.dart';

abstract class EstimationRepository {
  Future<Either<Failure, TrainResponseEntity>> train(TrainRequestEntity request);
  Future<Either<Failure, EstimationResponseEntity>> estimate(EstimationRequestEntity request);
}
