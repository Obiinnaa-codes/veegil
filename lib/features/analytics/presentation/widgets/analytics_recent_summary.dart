import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/presentation/widgets/transaction_item.dart';

class AnalyticsRecentSummary extends StatelessWidget {
  const AnalyticsRecentSummary({
    super.key,
    required this.transactions,
  });

  final List<Transaction> transactions;

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
          Text('Recent Summary', style: typography.title),
          const SizedBox(height: AppSpacing.lg),
          if (transactions.isEmpty)
            Text(
              'No recent deposit or withdrawal activity.',
              style: typography.body,
            )
          else
            Column(
              children: [
                for (var index = 0; index < transactions.length; index++) ...[
                  TransactionItem(
                    transaction: transactions[index],
                    compact: true,
                  ),
                  if (index < transactions.length - 1)
                    const SizedBox(height: AppSpacing.sm),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
