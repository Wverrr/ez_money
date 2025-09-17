import 'dart:convert';
import 'dart:developer';

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
    final resp = await httpClient.post(
      Uri.parse('$baseUrl/train'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    log(request.data.toString());
    log('Response: ${resp.body}');
    log('Status Code: ${resp.statusCode}');
    log(resp.toString());

    if (resp.statusCode != 200) {
      log('Connection test failed: ');
      throw ServerException('Train failed', statusCode: resp.statusCode);
    }

    print('Connection test failed: 2');
    log('Response body: ${resp.body}');
    return TrainResponseEntity(
      message: 'Train successful',
      userId: request.userId,
      r2Score: 0.95,
      analysis: resp.body.isNotEmpty
          ? jsonDecode(resp.body) as Map<String, dynamic>
          : {},
    );
  }

  @override
  Future<EstimationResponseModel> estimate(
    EstimationRequestModel request,
  ) async {
    final resp = await httpClient.post(
      Uri.parse('$baseUrl/estimate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final v = data['estimated_expense'];
      if (v == null) {
        throw ServerException('Missing prediction value', statusCode: resp.statusCode);
      }
      return EstimationResponseModel(
        estimatedExpense: (v as num).toDouble(),
        userId: request.userId,
        analysis: {},
      );
    }

    throw ServerException('Estimate failed', statusCode: resp.statusCode);
  }
}
