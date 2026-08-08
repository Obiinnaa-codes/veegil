import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.fullWidth = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        child: Container(
          width: fullWidth ? double.infinity : null,
          padding: EdgeInsets.symmetric(
            vertical: DashboardSpacing.cardPadding,
            horizontal: fullWidth ? DashboardSpacing.cardPadding : AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
            border: Border.all(color: AppColors.border),
          ),
          child: fullWidth
              ? Row(
                  children: [
                    Icon(icon, color: AppColors.primary, size: 28),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        label,
                        style: typography.label.copyWith(color: AppColors.text),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: AppColors.subtitle,
                      size: 20,
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: AppColors.primary, size: 28),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      label,
                      style: typography.label.copyWith(color: AppColors.text),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
