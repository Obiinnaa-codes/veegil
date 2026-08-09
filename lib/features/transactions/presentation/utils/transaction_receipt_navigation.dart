import 'package:flutter/material.dart';

import '../../../../shared/widgets/transaction_receipt_screen.dart';
import '../../domain/entities/transaction.dart';

void showTransactionReceiptFromHistory(
  BuildContext context,
  Transaction transaction,
) {
  showTransactionReceipt(
    context: context,
    transaction: transaction,
    onDone: () {},
  );
}
