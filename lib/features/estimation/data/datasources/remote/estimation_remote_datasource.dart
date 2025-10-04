import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/error/exception.dart';
import '../../../domain/entities/train_record_entity.dart';
import '../../models/estimate_model.dart';
import '../../models/train_record_model.dart';

abstract class EstimationRemoteDataSource {
  Future<TrainResponseEntity> train(TrainRequestModel request);
  Future<EstimationResponseModel> estimate(EstimationRequestModel model);
}

class EstimationRemoteDataSourceImpl implements EstimationRemoteDataSource {
  final http.Client httpClient;
  final String baseUrl;

  EstimationRemoteDataSourceImpl(this.httpClient, {required this.baseUrl});

  @override
  Future<TrainResponseEntity> train(TrainRequestModel request) async {
    final uri = Uri.parse('$baseUrl/train');
    try {
      final response = await httpClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return TrainResponseModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(
          'Gagal melatih model',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException('Tidak dapat terhubung ke server');
    }
  }

  @override
  Future<EstimationResponseModel> estimate(
    EstimationRequestModel request,
  ) async {
    final uri = Uri.parse('$baseUrl/estimate');
    try {
      final response = await httpClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return EstimationResponseModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerException(
          'Gagal melakukan estimasi',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException('Tidak dapat terhubung ke server');
    }
  }
}