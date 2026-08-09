import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/transaction.dart';
import 'transaction_receipt_formatters.dart';

abstract final class TransactionReceiptShare {
  static String buildShareText(Transaction transaction) {
    final buffer = StringBuffer()
      ..writeln('Veegil Transaction Receipt')
      ..writeln()
      ..writeln(TransactionReceiptFormatters.titleForCategory(transaction.category))
      ..writeln(TransactionReceiptFormatters.heroAmount(transaction))
      ..writeln(
        TransactionReceiptFormatters.descriptionForCategory(transaction.category),
      )
      ..writeln()
      ..writeln('Transaction Details');

    for (final row in TransactionReceiptFormatters.detailRows(transaction)) {
      buffer.writeln('${row.label}: ${row.value}');
    }

    return buffer.toString().trim();
  }

  static Future<void> shareReceipt({
    required BuildContext context,
    required Transaction transaction,
  }) async {
    try {
      await Clipboard.setData(
        ClipboardData(text: buildShareText(transaction)),
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receipt copied to clipboard')),
      );
    } catch (_) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to copy receipt. Please try again.'),
        ),
      );
    }
  }
}
