import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response_parser.dart';
import '../models/page_meta_model.dart';
import '../models/transaction_model.dart';

class TransactionsRemoteDataSource {
  TransactionsRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<({List<TransactionModel> items, PageMetaModel meta})> getTransactions({
    int limit = 50,
    int offset = 0,
  }) async {
    final response = await _apiClient.get<dynamic>(
      '/transactions',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );

    final payload = parseApiListEnvelope(response);
    final items = payload.items
        .map(TransactionModel.fromJson)
        .toList(growable: false);
    final meta = pageMetaFromEnvelope(payload.meta);

    return (items: items, meta: meta);
  }
}
