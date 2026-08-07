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
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

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
          padding: const EdgeInsets.symmetric(
            vertical: DashboardSpacing.cardPadding,
            horizontal: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
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
