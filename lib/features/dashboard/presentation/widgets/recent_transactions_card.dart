import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/route_paths.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../shared/widgets/app_surface_card.dart';
import '../../../../shared/widgets/inline_error_view.dart';
import '../../../transactions/presentation/controllers/transactions_controller.dart';
import '../../../transactions/presentation/utils/transaction_receipt_navigation.dart';
import '../../../transactions/presentation/widgets/transaction_item.dart';
import '../widgets/dashboard_shimmer.dart';

class RecentTransactionsCard extends ConsumerWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typography = context.typography;
    final transactionsState = ref.watch(transactionsControllerProvider);

    return AppSurfaceCard(
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
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
          transactionsState.when(
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
            error: (_, _) => InlineErrorView(
              message: 'Unable to load recent transactions.',
              onRetry: () => ref
                  .read(transactionsControllerProvider.notifier)
                  .refresh(),
              compact: true,
            ),
            data: (state) {
              final transactions = state.transactions.take(5).toList();

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
                      onTap: () => showTransactionReceiptFromHistory(
                        context,
                        transactions[i],
                      ),
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
