import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/account_spacing.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/widgets/app_surface_card.dart';
import '../../../profile/presentation/widgets/monthly_overview_item.dart';
import '../../../transactions/domain/entities/transaction_category.dart';

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
    final color = colorForCategory(context, category);
    final label = _labelForCategory(category);
    final transactionLabel =
        transactionCount == 1 ? 'Transaction' : 'Transactions';

    return AppSurfaceCard(
      useContainerHigh: false,
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AccountSpacing.iconCircleSize,
            height: AccountSpacing.iconCircleSize,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconForCategory(category),
              color: color,
              size: AccountSpacing.iconSize,
            ),
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
