import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/transaction_category.dart';

abstract final class TransactionColors {
  static Color forCategory(BuildContext context, TransactionCategory category) {
    final colors = context.appColors;
    switch (category) {
      case TransactionCategory.deposit:
        return AppColors.success;
      case TransactionCategory.withdraw:
        return AppColors.transactionWithdraw;
      case TransactionCategory.transfer:
        return AppColors.transactionTransfer;
      case TransactionCategory.unknown:
        return colors.subtitle;
    }
  }

  static String labelForCategory(TransactionCategory category, {String? note}) {
    switch (note?.toLowerCase()) {
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
