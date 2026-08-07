import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response_parser.dart';
import '../models/account_model.dart';

class DashboardRemoteDataSource {
  DashboardRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<AccountModel> getCurrentAccount() async {
    final response = await _apiClient.get<dynamic>('/accounts/me');
    final payload = parseApiEnvelope(response);
    return AccountModel.fromJson(payload);
  }
}
