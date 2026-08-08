import 'package:flutter/material.dart';

import '../../../../core/theme/account_spacing.dart';
import '../../../../core/theme/app_color_extension.dart';
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
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AccountSpacing.cardPadding),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AccountSpacing.cardBorderRadius),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 2),
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
            style: typography.label.copyWith(color: colors.text),
          ),
        ],
      ),
    );
  }
}
