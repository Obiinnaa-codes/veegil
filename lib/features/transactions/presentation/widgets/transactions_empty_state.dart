import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class TransactionsEmptyState extends StatelessWidget {
  const TransactionsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: AppColors.subtitle.withValues(alpha: 0.6),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No Transactions Yet',
              style: typography.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Your recent banking activity will appear here.',
              style: typography.body,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
