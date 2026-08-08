import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response_parser.dart';
import '../models/transfer_request.dart';

class TransferRemoteDataSource {
  TransferRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<void> transfer({
    required String phoneNumber,
    required int amount,
    required String idempotencyKey,
  }) async {
    final response = await _apiClient.post<dynamic>(
      '/accounts/transfer',
      data: TransferRequest(phoneNumber: phoneNumber, amount: amount).toJson(),
      options: Options(headers: {'Idempotency-Key': idempotencyKey}),
    );

    parseApiMutationEnvelope(response);
  }
}
