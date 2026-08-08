import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/core_providers.dart';
import '../../data/datasource/transfer_remote_data_source.dart';
import '../../data/repositories/transfer_repository_impl.dart';
import '../../domain/repositories/transfer_repository.dart';

final transferRemoteDataSourceProvider =
    Provider<TransferRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TransferRemoteDataSource(apiClient);
});

final transferRepositoryProvider = Provider<TransferRepository>((ref) {
  return TransferRepositoryImpl(
    remoteDataSource: ref.watch(transferRemoteDataSourceProvider),
  );
});
