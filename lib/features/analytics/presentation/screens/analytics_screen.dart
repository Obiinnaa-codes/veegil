import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../transactions/domain/entities/transaction_category.dart';
import '../../../transactions/presentation/controllers/transactions_controller.dart';
import '../controllers/analytics_data.dart';
import '../providers/analytics_providers.dart';
import '../../../../shared/widgets/veegil_refresh_indicator.dart';
import '../widgets/analytics_chart_card.dart';
import '../widgets/analytics_empty_state.dart';
import '../widgets/analytics_error_view.dart';
import '../widgets/analytics_insight_card.dart';
import '../widgets/analytics_shimmer.dart';
import '../widgets/analytics_stat_card.dart';
import '../widgets/analytics_summary_card.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  var _isLoadingAllTransactions = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_ensureAllTransactionsLoaded);
  }

  Future<void> _ensureAllTransactionsLoaded() async {
    if (_isLoadingAllTransactions || !mounted) {
      return;
    }

    _isLoadingAllTransactions = true;

    try {
      final notifier = ref.read(transactionsControllerProvider.notifier);

      while (mounted) {
        final state = ref.read(transactionsControllerProvider).valueOrNull;
        if (state == null || state.meta?.hasMore != true) {
          break;
        }
        await notifier.loadMore();
      }
    } finally {
      _isLoadingAllTransactions = false;
    }
  }

  Future<void> _onRefresh() async {
    await ref.read(transactionsControllerProvider.notifier).refresh();
    await _ensureAllTransactionsLoaded();
  }

  @override
  Widget build(BuildContext context) {
    final transactionsState = ref.watch(transactionsControllerProvider);
    final analyticsData = ref.watch(analyticsDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: SafeArea(
        child: transactionsState.when(
          loading: () => _AnalyticsScrollContent(
            child: const AnalyticsShimmer(),
          ),
          error: (_, _) => AnalyticsErrorView(
            onRetry: _onRefresh,
          ),
          data: (state) {
            if (state.transactions.isEmpty) {
              return VeegilRefreshIndicator(
                onRefresh: _onRefresh,
                child: _AnalyticsScrollContent(
                  child: const AnalyticsEmptyState(),
                ),
              );
            }

            final data = analyticsData;
            if (data == null) {
              return _AnalyticsScrollContent(
                child: const AnalyticsShimmer(),
              );
            }

            return VeegilRefreshIndicator(
              onRefresh: _onRefresh,
              child: _AnalyticsScrollContent(
                child: _AnalyticsBody(data: data),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AnalyticsBody extends StatelessWidget {
  const _AnalyticsBody({required this.data});

  final AnalyticsData data;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Summary', style: typography.title),
        const SizedBox(height: AppSpacing.md),
        AnalyticsSummaryCard(
          depositTotal: data.totalDeposits,
          depositCount: data.depositCount,
          withdrawalTotal: data.totalWithdrawals,
          withdrawalCount: data.withdrawCount,
        ),
        const SizedBox(height: AppSpacing.md),
        _StatCardsRow(
          depositTotal: data.totalDeposits,
          depositCount: data.depositCount,
          withdrawalTotal: data.totalWithdrawals,
          withdrawalCount: data.withdrawCount,
        ),
        const SizedBox(height: AppSpacing.md),
        AnalyticsChartCard(
          depositTotal: data.totalDeposits,
          withdrawalTotal: data.totalWithdrawals,
        ),
        const SizedBox(height: AppSpacing.md),
        AnalyticsInsightCard(
          depositTotal: data.totalDeposits,
          withdrawalTotal: data.totalWithdrawals,
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

class _StatCardsRow extends StatelessWidget {
  const _StatCardsRow({
    required this.depositTotal,
    required this.depositCount,
    required this.withdrawalTotal,
    required this.withdrawalCount,
  });

  final double depositTotal;
  final int depositCount;
  final double withdrawalTotal;
  final int withdrawalCount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stackVertically = constraints.maxWidth < 400;

        if (stackVertically) {
          return Column(
            children: [
              AnalyticsStatCard(
                category: TransactionCategory.deposit,
                amount: depositTotal,
                transactionCount: depositCount,
              ),
              const SizedBox(height: AppSpacing.md),
              AnalyticsStatCard(
                category: TransactionCategory.withdraw,
                amount: withdrawalTotal,
                transactionCount: withdrawalCount,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AnalyticsStatCard(
                category: TransactionCategory.deposit,
                amount: depositTotal,
                transactionCount: depositCount,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AnalyticsStatCard(
                category: TransactionCategory.withdraw,
                amount: withdrawalTotal,
                transactionCount: withdrawalCount,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AnalyticsScrollContent extends StatelessWidget {
  const _AnalyticsScrollContent({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.dashboardHorizontalPadding(),
            vertical: AppSpacing.md,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.dashboardMaxContentWidth(context),
                minHeight: constraints.maxHeight - AppSpacing.md * 2,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
