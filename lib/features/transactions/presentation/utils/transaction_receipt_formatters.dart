import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_category.dart';
import '../../domain/entities/transaction_direction.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';

class TransactionReceiptDetailRow {
  const TransactionReceiptDetailRow({
    required this.label,
    required this.value,
    this.isSelectable = false,
  });

  final String label;
  final String value;
  final bool isSelectable;
}

abstract final class TransactionReceiptFormatters {
  static String titleForCategory(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.deposit:
        return 'Deposit Successful';
      case TransactionCategory.withdraw:
        return 'Withdrawal Successful';
      case TransactionCategory.transfer:
        return 'Transfer Successful';
      case TransactionCategory.unknown:
        return 'Transaction Successful';
    }
  }

  static String descriptionForCategory(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.deposit:
        return 'Money has been added to your account.';
      case TransactionCategory.withdraw:
        return 'Money has been withdrawn from your account.';
      case TransactionCategory.transfer:
        return 'Money has been sent successfully.';
      case TransactionCategory.unknown:
        return 'Your transaction was completed successfully.';
    }
  }

  static String typeLabelForCategory(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.deposit:
        return 'Deposit';
      case TransactionCategory.withdraw:
        return 'Withdrawal';
      case TransactionCategory.transfer:
        return 'Transfer';
      case TransactionCategory.unknown:
        return 'Transaction';
    }
  }

  static const _minusSign = '\u2212';

  static String heroAmount(Transaction transaction) {
    return CurrencyFormatter.format(transaction.amount);
  }

  static String detailAmount(Transaction transaction) {
    final prefix =
        transaction.direction == TransactionDirection.debit ? _minusSign : '+';
    return '$prefix${CurrencyFormatter.format(transaction.amount)}';
  }

  static String? formatDateTime(DateTime? date) {
    if (date == null) return null;
    return '${DateFormatter.format(date)}, ${DateFormatter.formatTime(date)}';
  }

  static String? counterpartyLabel(Transaction transaction) {
    final counterparty = transaction.counterparty;
    if (counterparty == null || counterparty.isEmpty) return null;

    switch (transaction.direction) {
      case TransactionDirection.debit:
        return 'To';
      case TransactionDirection.credit:
        return 'From';
      case TransactionDirection.unknown:
        return null;
    }
  }

  static bool isSystemNote(String? note) {
    switch (note?.toLowerCase()) {
      case 'deposit':
      case 'withdrawal':
      case 'withdraw':
      case 'transfer':
      case 'transfer_in':
      case 'transfer_out':
        return true;
      default:
        return false;
    }
  }

  static String? userNote(Transaction transaction) {
    final note = transaction.note;
    if (note == null || note.isEmpty || isSystemNote(note)) return null;
    return note;
  }

  static List<TransactionReceiptDetailRow> detailRows(Transaction transaction) {
    final rows = <TransactionReceiptDetailRow>[
      TransactionReceiptDetailRow(
        label: 'Type',
        value: typeLabelForCategory(transaction.category),
      ),
    ];

    final counterpartyDirection = counterpartyLabel(transaction);
    final counterparty = transaction.counterparty;
    if (counterpartyDirection != null &&
        counterparty != null &&
        counterparty.isNotEmpty) {
      rows.add(
        TransactionReceiptDetailRow(
          label: counterpartyDirection,
          value: counterparty,
        ),
      );
    }

    rows.add(
      TransactionReceiptDetailRow(
        label: 'Amount',
        value: detailAmount(transaction),
      ),
    );

    final dateTime = formatDateTime(transaction.created);
    if (dateTime != null) {
      rows.add(TransactionReceiptDetailRow(label: 'Date', value: dateTime));
    }

    if (transaction.id.isNotEmpty) {
      rows.add(
        TransactionReceiptDetailRow(
          label: 'Transaction ID',
          value: transaction.id,
          isSelectable: true,
        ),
      );
    }

    final balance = transaction.balance;
    if (balance != null) {
      rows.add(
        TransactionReceiptDetailRow(
          label: 'Balance After Transaction',
          value: CurrencyFormatter.format(balance),
        ),
      );
    }

    final note = userNote(transaction);
    if (note != null) {
      rows.add(TransactionReceiptDetailRow(label: 'Note', value: note));
    }

    return rows;
  }
}
