import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_direction.dart';
import '../utils/transaction_colors.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    this.compact = false,
  });

  final Transaction transaction;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;
    final accentColor = TransactionColors.forCategory(context, transaction.category);
    final categoryLabel =
        TransactionColors.labelForCategory(transaction.category, note: transaction.note);
    final directionLabel = _directionLabel(transaction.direction);
    final counterpartyLabel = _counterpartyLabel(transaction);

    return Container(
      padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${DateFormatter.format(transaction.created)} · ${DateFormatter.formatTime(transaction.created)}',
                        style: typography.caption,
                      ),
                    ),
                    _DirectionBadge(
                      label: directionLabel,
                      color: accentColor,
                    ),
                  ],
                ),
                if (!compact && counterpartyLabel != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    counterpartyLabel,
                    style: typography.caption.copyWith(color: colors.text),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(Transaction transaction) {
    final prefix = transaction.direction == TransactionDirection.debit ? '-' : '+';
    return '$prefix${CurrencyFormatter.format(transaction.amount)}';
  }

  String _directionLabel(TransactionDirection direction) {
    switch (direction) {
      case TransactionDirection.credit:
        return 'Credit';
      case TransactionDirection.debit:
        return 'Debit';
      case TransactionDirection.unknown:
        return '—';
    }
  }

  String? _counterpartyLabel(Transaction transaction) {
    final counterparty = transaction.counterparty;
    if (counterparty == null || counterparty.isEmpty) return null;

    switch (transaction.direction) {
      case TransactionDirection.debit:
        return 'To $counterparty';
      case TransactionDirection.credit:
        return 'From $counterparty';
      case TransactionDirection.unknown:
        return counterparty;
    }
  }
}

class _DirectionBadge extends StatelessWidget {
  const _DirectionBadge({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: typography.label.copyWith(color: color),
      ),
    );
  }
}
