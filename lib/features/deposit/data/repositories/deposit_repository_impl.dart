import '../../domain/repositories/deposit_repository.dart';
import '../datasource/deposit_remote_data_source.dart';

class DepositRepositoryImpl implements DepositRepository {
  DepositRepositoryImpl({
    required DepositRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final DepositRemoteDataSource _remoteDataSource;

  @override
  Future<void> deposit(int amount) async {
    await _remoteDataSource.deposit(amount);
  }
}
