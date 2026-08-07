import '../entities/transactions_page.dart';

abstract class TransactionRepository {
  Future<TransactionsPage> getTransactions({
    int limit = 50,
    int offset = 0,
  });
}
