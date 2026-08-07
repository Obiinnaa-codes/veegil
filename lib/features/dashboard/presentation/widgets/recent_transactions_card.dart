import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Transactions',
            style: typography.title,
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Text(
                'No transactions yet.',
                style: typography.caption,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
