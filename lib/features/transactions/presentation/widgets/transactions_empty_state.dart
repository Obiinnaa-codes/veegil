import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/entities/transaction_filter.dart';

class TransactionsEmptyState extends StatelessWidget {
  const TransactionsEmptyState({
    super.key,
    this.activeFilter = TransactionFilter.all,
    this.hasTransactions = false,
    this.onClearFilter,
  });

  final TransactionFilter activeFilter;
  final bool hasTransactions;
  final VoidCallback? onClearFilter;

  bool get _isFilteredEmpty =>
      hasTransactions && activeFilter != TransactionFilter.all;

  String get _title {
    if (!_isFilteredEmpty) return 'No Transactions Yet';

    switch (activeFilter) {
      case TransactionFilter.deposit:
        return 'No Deposits Found';
      case TransactionFilter.withdraw:
        return 'No Withdrawals Found';
      case TransactionFilter.transfer:
        return 'No Transfers Found';
      case TransactionFilter.all:
        return 'No Transactions Yet';
    }
  }

  String get _message {
    if (!_isFilteredEmpty) {
      return 'Your recent banking activity will appear here.';
    }
    return 'Try another filter to see more transactions.';
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: colors.subtitle.withValues(alpha: 0.6),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              _title,
              style: typography.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _message,
              style: typography.body,
              textAlign: TextAlign.center,
            ),
            if (_isFilteredEmpty && onClearFilter != null) ...[
              const SizedBox(height: AppSpacing.lg),
              TextButton(
                onPressed: onClearFilter,
                child: const Text('Clear Filter'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
