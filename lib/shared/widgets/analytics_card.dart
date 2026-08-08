import 'package:flutter/material.dart';

import '../../core/theme/account_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class AnalyticsCard extends StatelessWidget {
  const AnalyticsCard({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AccountSpacing.cardBorderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AccountSpacing.cardBorderRadius),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AccountSpacing.cardPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AccountSpacing.cardBorderRadius),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 12,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: AccountSpacing.iconCircleSize,
                height: AccountSpacing.iconCircleSize,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  color: AppColors.primary,
                  size: AccountSpacing.iconSize,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analytics',
                      style: typography.body.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Track your deposits and withdrawals',
                      style: typography.caption,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.subtitle,
                size: AccountSpacing.iconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
