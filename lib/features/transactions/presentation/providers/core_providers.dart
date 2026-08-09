import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/core_providers.dart';
import '../../data/datasource/transactions_remote_data_source.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/transaction_repository.dart';

final transactionsRemoteDataSourceProvider =
    Provider<TransactionsRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TransactionsRemoteDataSource(apiClient);
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl(
    remoteDataSource: ref.watch(transactionsRemoteDataSourceProvider),
  );
});
