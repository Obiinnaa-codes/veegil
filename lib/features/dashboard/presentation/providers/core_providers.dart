import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/core_providers.dart';
import '../../data/datasource/dashboard_remote_data_source.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';

final dashboardRemoteDataSourceProvider =
    Provider<DashboardRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardRemoteDataSource(apiClient);
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    remoteDataSource: ref.watch(dashboardRemoteDataSourceProvider),
  );
});
