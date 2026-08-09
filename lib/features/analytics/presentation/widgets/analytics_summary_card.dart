import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/widgets/app_surface_card.dart';

class AnalyticsSummaryCard extends StatelessWidget {
  const AnalyticsSummaryCard({
    super.key,
    required this.depositTotal,
    required this.depositCount,
    required this.withdrawalTotal,
    required this.withdrawalCount,
  });

  final double depositTotal;
  final int depositCount;
  final double withdrawalTotal;
  final int withdrawalCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryTile(
            label: 'Deposits',
            amount: depositTotal,
            transactionCount: depositCount,
            accentColor: AppColors.success,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _SummaryTile(
            label: 'Withdrawals',
            amount: withdrawalTotal,
            transactionCount: withdrawalCount,
            accentColor: AppColors.transactionWithdraw,
          ),
        ),
      ],
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.amount,
    required this.transactionCount,
    required this.accentColor,
  });

  final String label;
  final double amount;
  final int transactionCount;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final transactionLabel =
        transactionCount == 1 ? 'Transaction' : 'Transactions';

    return AppSurfaceCard(
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: typography.caption,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            CurrencyFormatter.format(amount),
            style: typography.title,
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
}
