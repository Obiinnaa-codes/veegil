import '../../domain/repositories/withdraw_repository.dart';
import '../datasource/withdraw_remote_data_source.dart';

class WithdrawRepositoryImpl implements WithdrawRepository {
  WithdrawRepositoryImpl({
    required WithdrawRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final WithdrawRemoteDataSource _remoteDataSource;

  @override
  Future<void> withdraw(int amount) async {
    await _remoteDataSource.withdraw(amount);
  }
}
