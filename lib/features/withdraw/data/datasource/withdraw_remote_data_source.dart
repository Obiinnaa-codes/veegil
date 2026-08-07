import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response_parser.dart';
import '../models/withdraw_request.dart';

class WithdrawRemoteDataSource {
  WithdrawRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<void> withdraw(int amount) async {
    final response = await _apiClient.post<dynamic>(
      '/accounts/withdraw',
      data: WithdrawRequest(amount: amount).toJson(),
    );

    parseApiMutationEnvelope(response);
  }
}
