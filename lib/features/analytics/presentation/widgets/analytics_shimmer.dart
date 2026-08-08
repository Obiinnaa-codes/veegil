import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../dashboard/presentation/widgets/dashboard_shimmer.dart';

class AnalyticsShimmer extends StatelessWidget {
  const AnalyticsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ShimmerBox(width: 120, height: 24),
        const SizedBox(height: AppSpacing.lg),
        const ShimmerBox(width: double.infinity, height: 1),
        const SizedBox(height: AppSpacing.lg),
        const ShimmerBox(width: double.infinity, height: 20),
        const SizedBox(height: AppSpacing.md),
        const ShimmerBox(width: double.infinity, height: 20),
        const SizedBox(height: AppSpacing.lg),
        const ShimmerBox(width: double.infinity, height: 1),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppConstants.cardBorderRadius),
                ),
                child: const ShimmerBox(width: double.infinity, height: 100),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppConstants.cardBorderRadius),
                ),
                child: const ShimmerBox(width: double.infinity, height: 100),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const ShimmerBox(width: double.infinity, height: 1),
        const SizedBox(height: AppSpacing.lg),
        const ShimmerBox(width: 80, height: 20),
        const SizedBox(height: AppSpacing.md),
        const ShimmerBox(width: double.infinity, height: 220),
        const SizedBox(height: AppSpacing.lg),
        const ShimmerBox(width: double.infinity, height: 1),
        const SizedBox(height: AppSpacing.lg),
        const ShimmerBox(width: 80, height: 20),
        const SizedBox(height: AppSpacing.md),
        const ShimmerBox(width: double.infinity, height: 72),
      ],
    );
  }
}
