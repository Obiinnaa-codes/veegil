import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/core_providers.dart';
import '../../data/datasource/withdraw_remote_data_source.dart';
import '../../data/repositories/withdraw_repository_impl.dart';
import '../../domain/repositories/withdraw_repository.dart';

final withdrawRemoteDataSourceProvider =
    Provider<WithdrawRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return WithdrawRemoteDataSource(apiClient);
});

final withdrawRepositoryProvider = Provider<WithdrawRepository>((ref) {
  return WithdrawRepositoryImpl(
    remoteDataSource: ref.watch(withdrawRemoteDataSourceProvider),
  );
});
