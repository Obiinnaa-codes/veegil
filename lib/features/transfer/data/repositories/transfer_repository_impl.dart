import '../../domain/repositories/transfer_repository.dart';
import '../datasource/transfer_remote_data_source.dart';

class TransferRepositoryImpl implements TransferRepository {
  TransferRepositoryImpl({
    required TransferRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final TransferRemoteDataSource _remoteDataSource;

  @override
  Future<void> transfer({
    required String phoneNumber,
    required int amount,
    required String idempotencyKey,
  }) async {
    await _remoteDataSource.transfer(
      phoneNumber: phoneNumber,
      amount: amount,
      idempotencyKey: idempotencyKey,
    );
  }
}
