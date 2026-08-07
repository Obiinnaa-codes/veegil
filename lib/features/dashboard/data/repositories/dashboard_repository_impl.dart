import '../../domain/entities/account.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasource/dashboard_remote_data_source.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl({required DashboardRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final DashboardRemoteDataSource _remoteDataSource;

  @override
  Future<Account> getCurrentUser() async {
    final model = await _remoteDataSource.getCurrentAccount();
    return model.toEntity();
  }

  @override
  Future<Account> refresh() async {
    final model = await _remoteDataSource.getCurrentAccount();
    return model.toEntity();
  }
}
