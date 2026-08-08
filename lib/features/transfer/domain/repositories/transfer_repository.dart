abstract class TransferRepository {
  Future<void> transfer({
    required String phoneNumber,
    required int amount,
    required String idempotencyKey,
  });
}
