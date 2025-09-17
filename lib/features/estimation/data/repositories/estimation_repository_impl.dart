import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/estimation_entity.dart';
import '../../domain/entities/train_record_entity.dart';
import '../../domain/repositories/estimation_repository.dart';
import '../datasources/remote/estimation_remote_datasource.dart';
import '../models/estimate_model.dart';
import '../models/train_record_model.dart';

class EstimationRepositoryImpl implements EstimationRepository {
  final EstimationRemoteDataSource remoteDataSource;

  EstimationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, EstimationResponseEntity>> estimate(EstimationRequestEntity request) async {
    print('repository estimate called');
    try {
      final model = EstimationRequestModel.fromEntity(request);
      final result = await remoteDataSource.estimate(model);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure("${e.message}, Status Code: ${e.statusCode}"));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TrainResponseEntity>> train(TrainRequestEntity request) async {
    
    try {
      
      final model = TrainRequestModel.fromEntity(request);
      final result = await remoteDataSource.train(model);
      log('Train successful, returning result: $result');
      return Right(result);
    } on ServerException catch (e) {
      log('ServerException caught: ${e.message}');
      return Left(Failure("${e.message}, Status Code: ${e.statusCode}"));
    } catch (e) {
      log('General exception caught: $e');
      return Left(Failure(e.toString()));
    }
  }
}
