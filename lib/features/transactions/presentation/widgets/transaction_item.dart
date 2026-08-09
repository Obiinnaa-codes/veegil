import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_surface_card.dart';
import '../../../../core/utils/phone_formatter.dart';
import '../../../../core/utils/validators.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_category.dart';
import '../../domain/entities/transaction_direction.dart';
import '../utils/transaction_colors.dart';
import 'transaction_type_icon.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    this.compact = false,
    this.onTap,
  });

  final Transaction transaction;
  final bool compact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;
    final accentColor = TransactionColors.forCategory(context, transaction.category);
    final categoryLabel =
        TransactionColors.labelForCategory(transaction.category, note: transaction.note);
    final counterpartyLabel = _counterpartyLabel(transaction);
    final showsIconBadge = _showsIconBadge(transaction.category);

    return AppSurfaceCard(
      onTap: onTap,
      padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showsIconBadge)
            TransactionTypeIcon.forTransaction(
              transaction: transaction,
              color: accentColor,
            )
          else
            Container(
              width: 4,
              height: compact ? 48 : 56,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        categoryLabel,
                        style: typography.title.copyWith(fontSize: compact ? 15 : 16),
                      ),
                    ),
                    Text(
                      _formatAmount(transaction),
                      style: typography.title.copyWith(
                        color: accentColor,
                        fontSize: compact ? 15 : 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${DateFormatter.format(transaction.created)} · ${DateFormatter.formatTime(transaction.created)}',
                  style: typography.caption,
                ),
                if (counterpartyLabel != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    counterpartyLabel,
                    style: typography.caption.copyWith(
                      color: colors.text,
                      fontSize: compact ? 12 : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _showsIconBadge(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.deposit:
      case TransactionCategory.withdraw:
      case TransactionCategory.transfer:
        return true;
      case TransactionCategory.unknown:
        return false;
    }
  }

  String _formatAmount(Transaction transaction) {
    final prefix = transaction.direction == TransactionDirection.debit ? '-' : '+';
    return '$prefix${CurrencyFormatter.format(transaction.amount)}';
  }

  String? _counterpartyLabel(Transaction transaction) {
    final counterparty = transaction.counterparty;
    if (counterparty == null || counterparty.isEmpty) return null;

    final display = _formatCounterparty(counterparty);

    switch (transaction.direction) {
      case TransactionDirection.debit:
        return 'To $display';
      case TransactionDirection.credit:
        return 'From $display';
      case TransactionDirection.unknown:
        return display;
    }
  }

  String _formatCounterparty(String counterparty) {
    final trimmed = counterparty.trim();
    if (Validators.phone(trimmed) == null) {
      return PhoneFormatter.mask(trimmed);
    }
    return counterparty;
  }
}
