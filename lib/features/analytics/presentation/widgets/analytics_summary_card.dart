import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_color_extension.dart';
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
    final colors = context.appColors;

    return AppSurfaceCard(
      useContainerHigh: false,
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _SummaryColumn(
                indicatorColor: AppColors.success,
                label: 'Total Deposits',
                amount: depositTotal,
                transactionCount: depositCount,
              ),
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: colors.outlineVariant,
            ),
            Expanded(
              child: _SummaryColumn(
                indicatorColor: AppColors.transactionWithdraw,
                label: 'Total Withdrawals',
                amount: withdrawalTotal,
                transactionCount: withdrawalCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryColumn extends StatelessWidget {
  const _SummaryColumn({
    required this.indicatorColor,
    required this.label,
    required this.amount,
    required this.transactionCount,
  });

  final Color indicatorColor;
  final String label;
  final double amount;
  final int transactionCount;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;
    final transactionLabel =
        transactionCount == 1 ? 'Transaction' : 'Transactions';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: typography.caption.copyWith(color: colors.subtitle),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              CurrencyFormatter.format(amount),
              style: typography.heading.copyWith(fontSize: 22),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '$transactionCount $transactionLabel',
            style: typography.caption.copyWith(color: colors.subtitle),
          ),
        ],
      ),
    );
  }
}
