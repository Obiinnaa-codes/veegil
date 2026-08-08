import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';

class AnalyticsStatisticsSection extends StatelessWidget {
  const AnalyticsStatisticsSection({
    super.key,
    required this.depositCount,
    required this.withdrawCount,
    required this.transferCount,
  });

  final int depositCount;
  final int withdrawCount;
  final int transferCount;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Statistics', style: typography.title),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  label: 'Deposits',
                  value: depositCount.toString(),
                  color: AppColors.success,
                ),
              ),
              Expanded(
                child: _StatTile(
                  label: 'Withdrawals',
                  value: withdrawCount.toString(),
                  color: AppColors.transactionWithdraw,
                ),
              ),
              Expanded(
                child: _StatTile(
                  label: 'Transfers',
                  value: transferCount.toString(),
                  color: AppColors.transactionTransfer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      children: [
        Text(
          value,
          style: typography.heading.copyWith(color: color),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: typography.caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
