
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/train_record_entity.dart';
import '../repositories/estimation_repository.dart';

class TrainRecord {
  final EstimationRepository repository;
  TrainRecord(this.repository);

  Future<Either<Failure, TrainResponseEntity>> execute(TrainRequestEntity request) => repository.train(request);
}