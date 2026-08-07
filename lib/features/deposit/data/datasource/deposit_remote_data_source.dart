import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response_parser.dart';
import '../models/deposit_request.dart';

class DepositRemoteDataSource {
  DepositRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<void> deposit(int amount) async {
    final response = await _apiClient.post<dynamic>(
      '/accounts/deposit',
      data: DepositRequest(amount: amount).toJson(),
    );

    parseApiMutationEnvelope(response);
  }
}
