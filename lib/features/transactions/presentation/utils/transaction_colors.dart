import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_category.dart';
import '../../domain/entities/transaction_direction.dart';

abstract final class TransactionColors {
  static Color forCategory(BuildContext context, TransactionCategory category) {
    return forCategoryBrightness(category);
  }

  static Color forCategoryBrightness(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.deposit:
        return AppColors.success;
      case TransactionCategory.withdraw:
        return AppColors.transactionWithdraw;
      case TransactionCategory.transfer:
        return AppColors.transactionTransfer;
      case TransactionCategory.unknown:
        return AppColors.subtitle;
    }
  }

  static IconData iconForCategory(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.deposit:
        return Icons.arrow_downward_rounded;
      case TransactionCategory.withdraw:
        return Icons.arrow_upward_rounded;
      case TransactionCategory.transfer:
        return Icons.swap_horiz_rounded;
      case TransactionCategory.unknown:
        return Icons.receipt_long_outlined;
    }
  }

  static IconData iconForTransaction(Transaction transaction) {
    switch (transaction.note?.toLowerCase()) {
      case 'transfer_in':
        return Icons.call_received_rounded;
      case 'transfer_out':
        return Icons.call_made_rounded;
    }

    if (transaction.category == TransactionCategory.transfer) {
      switch (transaction.direction) {
        case TransactionDirection.credit:
          return Icons.call_received_rounded;
        case TransactionDirection.debit:
          return Icons.call_made_rounded;
        case TransactionDirection.unknown:
          return Icons.swap_horiz_rounded;
      }
    }

    return iconForCategory(transaction.category);
  }

  static String labelForCategory(TransactionCategory category, {String? note}) {    switch (note?.toLowerCase()) {
      case 'transfer_in':
        return 'Transfer In';
      case 'transfer_out':
        return 'Transfer Out';
    }

    if (note != null && note.isNotEmpty && category == TransactionCategory.unknown) {
      return note[0].toUpperCase() + note.substring(1);
    }

    switch (category) {
      case TransactionCategory.deposit:
        return 'Deposit';
      case TransactionCategory.withdraw:
        return 'Withdraw';
      case TransactionCategory.transfer:
        return 'Transfer';
      case TransactionCategory.unknown:
        return 'Transaction';
    }
  }
}
