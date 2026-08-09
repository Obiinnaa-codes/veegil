import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_color_extension.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'app_surface_card.dart';

class AvailableBalanceBanner extends ConsumerWidget {
  const AvailableBalanceBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typography = context.typography;
    final colors = context.appColors;
    final balance = ref.watch(dashboardControllerProvider).valueOrNull?.balance;

    return AppSurfaceCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Text(
            'Available Balance',
            style: typography.caption,
          ),
          const Spacer(),
          Text(
            balance != null ? CurrencyFormatter.format(balance) : '—',
            style: typography.body.copyWith(
              color: colors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
