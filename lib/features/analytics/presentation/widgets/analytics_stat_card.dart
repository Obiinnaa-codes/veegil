import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/widgets/app_surface_card.dart';
import '../../../transactions/domain/entities/transaction_category.dart';
import '../../../transactions/presentation/utils/transaction_colors.dart';
import '../../../transactions/presentation/widgets/transaction_type_icon.dart';

class AnalyticsStatCard extends StatelessWidget {
  const AnalyticsStatCard({
    super.key,
    required this.category,
    required this.amount,
    required this.transactionCount,
  });

  final TransactionCategory category;
  final double amount;
  final int transactionCount;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final color = TransactionColors.forCategory(context, category);
    final label = _labelForCategory(category);
    final transactionLabel =
        transactionCount == 1 ? 'Transaction' : 'Transactions';

    return AppSurfaceCard(
      useContainerHigh: false,
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TransactionTypeIcon(
            category: category,
            color: color,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(label, style: typography.caption),
          const SizedBox(height: AppSpacing.xs),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              CurrencyFormatter.format(amount),
              style: typography.title,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '$transactionCount $transactionLabel',
            style: typography.caption,
          ),
        ],
      ),
    );
  }

  String _labelForCategory(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.deposit:
        return 'Deposits';
      case TransactionCategory.withdraw:
        return 'Withdrawals';
      case TransactionCategory.transfer:
        return 'Transfers';
      case TransactionCategory.unknown:
        return 'Other';
    }
  }
}
