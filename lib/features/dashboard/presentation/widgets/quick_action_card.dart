import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../shared/widgets/app_surface_card.dart';

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
    final colors = context.appColors;

    return AppSurfaceCard(
      onTap: onTap,
      padding: EdgeInsets.symmetric(
        vertical: DashboardSpacing.cardPadding,
        horizontal: fullWidth ? DashboardSpacing.cardPadding : AppSpacing.sm,
      ),
      child: fullWidth
          ? Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 28),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    label,
                    style: typography.label.copyWith(color: colors.text),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colors.subtitle,
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
                  style: typography.label.copyWith(color: colors.text),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
