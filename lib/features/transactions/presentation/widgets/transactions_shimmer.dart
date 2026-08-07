import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../dashboard/presentation/widgets/dashboard_shimmer.dart';

class TransactionsShimmer extends StatelessWidget {
  const TransactionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, _) => ShimmerBox(
        width: double.infinity,
        height: 88,
        borderRadius: AppConstants.cardBorderRadius,
      ),
    );
  }
}
