import 'package:flutter/material.dart';

import '../../../../shared/widgets/transaction_receipt_screen.dart';
import '../../domain/entities/transaction.dart';
import '../models/transaction_receipt_mode.dart';

void showTransactionReceiptFromHistory(
  BuildContext context,
  Transaction transaction,
) {
  showTransactionReceipt(
    context: context,
    transaction: transaction,
    mode: TransactionReceiptMode.detail,
    onDone: () {},
  );
}