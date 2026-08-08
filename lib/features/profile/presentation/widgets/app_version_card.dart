import 'package:flutter/material.dart';

import '../../../../core/theme/account_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AppVersionCard extends StatelessWidget {
  const AppVersionCard({
    super.key,
    required this.version,
  });

  final String version;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AccountSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
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
              Icons.info_outline,
              color: AppColors.primary,
              size: AccountSpacing.iconSize,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'App Version',
              style: typography.body.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            version,
            style: typography.label.copyWith(color: AppColors.text),
          ),
        ],
      ),
    );
  }
}
