import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../shared/widgets/app_surface_card.dart';
import '../utils/analytics_formatters.dart';

class AnalyticsInsightCard extends StatelessWidget {
  const AnalyticsInsightCard({
    super.key,
    required this.depositTotal,
    required this.withdrawalTotal,
  });

  final double depositTotal;
  final double withdrawalTotal;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;
    final insight = AnalyticsFormatters.buildInsight(
      depositTotal,
      withdrawalTotal,
    );

    return AppSurfaceCard(
      useContainerHigh: false,
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              depositTotal >= withdrawalTotal
                  ? Icons.trending_up_rounded
                  : Icons.info_outline_rounded,
              color: AppColors.primary,
              size: 24,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insight.title,
                    style: typography.title.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    insight.message,
                    style: typography.body.copyWith(color: colors.subtitle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
