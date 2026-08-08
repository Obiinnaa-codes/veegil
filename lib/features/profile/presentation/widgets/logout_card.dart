import 'package:flutter/material.dart';

import '../../../../core/theme/account_spacing.dart';
import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class LogoutCard extends StatelessWidget {
  const LogoutCard({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AccountSpacing.cardBorderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AccountSpacing.cardBorderRadius),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AccountSpacing.cardPadding),
          decoration: BoxDecoration(
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
                  color: AppColors.error.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout,
                  color: AppColors.error,
                  size: AccountSpacing.iconSize,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logout',
                      style: typography.body.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Sign out of your account',
                      style: typography.caption,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: colors.subtitle,
                size: AccountSpacing.iconSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
