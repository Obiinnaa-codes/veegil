import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/domain/entities/transaction_category.dart';

class DailyActivity {
  const DailyActivity({
    required this.date,
    required this.deposits,
    required this.withdrawals,
  });

  final DateTime date;
  final double deposits;
  final double withdrawals;
}

class AnalyticsData {
  const AnalyticsData({
    required this.totalDeposits,
    required this.totalWithdrawals,
    required this.depositCount,
    required this.withdrawCount,
    required this.transferCount,
    required this.last7DaysDeposits,
    required this.last7DaysWithdrawals,
    required this.last7DaysDaily,
    required this.recentDepositWithdrawals,
  });

  final double totalDeposits;
  final double totalWithdrawals;
  final int depositCount;
  final int withdrawCount;
  final int transferCount;
  final double last7DaysDeposits;
  final double last7DaysWithdrawals;
  final List<DailyActivity> last7DaysDaily;
  final List<Transaction> recentDepositWithdrawals;

  factory AnalyticsData.fromTransactions(
    List<Transaction> transactions, {
    DateTime? referenceDate,
  }) {
    final anchor = referenceDate ?? DateTime.now();
    final startOfMonth = DateTime(anchor.year, anchor.month);
    final today = DateTime(anchor.year, anchor.month, anchor.day);

    double totalDeposits = 0;
    double totalWithdrawals = 0;
    var depositCount = 0;
    var withdrawCount = 0;
    var transferCount = 0;

    final last7DaysDaily = _buildLast7DaysDaily(transactions, today);

    for (final transaction in transactions) {
      final created = transaction.created;
      if (created == null) continue;

      final inMonth = !created.isBefore(startOfMonth);

      if (inMonth) {
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
    }

    final last7DaysDeposits = last7DaysDaily.fold(
      0.0,
      (sum, day) => sum + day.deposits,
    );
    final last7DaysWithdrawals = last7DaysDaily.fold(
      0.0,
      (sum, day) => sum + day.withdrawals,
    );

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
      last7DaysDeposits: last7DaysDeposits,
      last7DaysWithdrawals: last7DaysWithdrawals,
      last7DaysDaily: last7DaysDaily,
      recentDepositWithdrawals:
          recentDepositWithdrawals.take(5).toList(growable: false),
    );
  }

  static List<DailyActivity> _buildLast7DaysDaily(
    List<Transaction> transactions,
    DateTime today,
  ) {
    final days = List.generate(
      7,
      (index) => today.subtract(Duration(days: 6 - index)),
    );
    final deposits = List<double>.filled(7, 0);
    final withdrawals = List<double>.filled(7, 0);

    for (final transaction in transactions) {
      final created = transaction.created;
      if (created == null) continue;

      final day = DateTime(created.year, created.month, created.day);
      final dayIndex = days.indexWhere(
        (d) => d.year == day.year && d.month == day.month && d.day == day.day,
      );
      if (dayIndex < 0) continue;

      switch (transaction.category) {
        case TransactionCategory.deposit:
          deposits[dayIndex] += transaction.amount;
        case TransactionCategory.withdraw:
          withdrawals[dayIndex] += transaction.amount;
        case TransactionCategory.transfer:
        case TransactionCategory.unknown:
          break;
      }
    }

    return List.generate(
      7,
      (index) => DailyActivity(
        date: days[index],
        deposits: deposits[index],
        withdrawals: withdrawals[index],
      ),
    );
  }
}
