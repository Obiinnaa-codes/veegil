import '../../domain/entities/transactions_page.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasource/transactions_remote_data_source.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl({
    required TransactionsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final TransactionsRemoteDataSource _remoteDataSource;

  @override
  Future<TransactionsPage> getTransactions({
    int limit = 50,
    int offset = 0,
  }) async {
    final result = await _remoteDataSource.getTransactions(
      limit: limit,
      offset: offset,
    );

    return TransactionsPage(
      items: result.items.map((model) => model.toEntity()).toList(),
      meta: result.meta.toEntity(),
    );
  }
}
