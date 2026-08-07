import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/core_providers.dart';
import '../../data/datasource/deposit_remote_data_source.dart';
import '../../data/repositories/deposit_repository_impl.dart';
import '../../domain/repositories/deposit_repository.dart';

final depositRemoteDataSourceProvider =
    Provider<DepositRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DepositRemoteDataSource(apiClient);
});

final depositRepositoryProvider = Provider<DepositRepository>((ref) {
  return DepositRepositoryImpl(
    remoteDataSource: ref.watch(depositRemoteDataSourceProvider),
  );
});
