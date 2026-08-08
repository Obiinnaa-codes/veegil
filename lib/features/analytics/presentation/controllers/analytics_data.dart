import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/entities/transaction_category.dart';

class AnalyticsData {
  const AnalyticsData({
    required this.totalDeposits,
    required this.totalWithdrawals,
    required this.depositCount,
    required this.withdrawCount,
    required this.transferCount,
    required this.recentDepositWithdrawals,
  });

  final double totalDeposits;
  final double totalWithdrawals;
  final int depositCount;
  final int withdrawCount;
  final int transferCount;
  final List<Transaction> recentDepositWithdrawals;

  factory AnalyticsData.fromTransactions(List<Transaction> transactions) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month);

    double totalDeposits = 0;
    double totalWithdrawals = 0;
    var depositCount = 0;
    var withdrawCount = 0;
    var transferCount = 0;

    for (final transaction in transactions) {
      final created = transaction.created;
      if (created == null || created.isBefore(startOfMonth)) {
        continue;
      }

      switch (transaction.category) {
        case TransactionCategory.deposit:
          totalDeposits += transaction.amount;
          depositCount++;
        case TransactionCategory.withdraw:
          totalWithdrawals += transaction.amount;
          withdrawCount++;
        case TransactionCategory.transfer:
          transferCount++;
        case TransactionCategory.unknown:
          break;
      }
    }

    final recentDepositWithdrawals = transactions
        .where(
          (transaction) =>
              transaction.category == TransactionCategory.deposit ||
              transaction.category == TransactionCategory.withdraw,
        )
        .toList()
      ..sort((a, b) {
        final aCreated = a.created ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bCreated = b.created ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bCreated.compareTo(aCreated);
      });

    return AnalyticsData(
      totalDeposits: totalDeposits,
      totalWithdrawals: totalWithdrawals,
      depositCount: depositCount,
      withdrawCount: withdrawCount,
      transferCount: transferCount,
      recentDepositWithdrawals:
          recentDepositWithdrawals.take(5).toList(growable: false),
    );
  }
}
