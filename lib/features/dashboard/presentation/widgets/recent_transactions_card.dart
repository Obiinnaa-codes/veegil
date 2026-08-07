import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/route_paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../transactions/presentation/providers/core_providers.dart';
import '../../../transactions/presentation/widgets/transaction_item.dart';
import '../widgets/dashboard_shimmer.dart';

class RecentTransactionsCard extends ConsumerWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typography = context.typography;
    final recentTransactions = ref.watch(recentTransactionsProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Recent Transactions',
                  style: typography.title,
                ),
              ),
              TextButton(
                onPressed: () => context.go(RoutePaths.transactions),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          recentTransactions.when(
            loading: () => Column(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    bottom: index == 2 ? 0 : AppSpacing.sm,
                  ),
                  child: const ShimmerBox(
                    width: double.infinity,
                    height: 72,
                    borderRadius: AppConstants.cardBorderRadius,
                  ),
                ),
              ),
            ),
            error: (_, _) => Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Text(
                  'Unable to load recent transactions.',
                  style: typography.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            data: (transactions) {
              if (transactions.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    child: Text(
                      'No transactions yet.',
                      style: typography.caption,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  for (var i = 0; i < transactions.length; i++) ...[
                    TransactionItem(
                      transaction: transactions[i],
                      compact: true,
                    ),
                    if (i < transactions.length - 1)
                      const SizedBox(height: AppSpacing.sm),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
