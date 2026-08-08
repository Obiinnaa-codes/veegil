import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/section_spacing.dart';
import '../../../dashboard/presentation/widgets/dashboard_error_view.dart';
import '../../../transactions/presentation/controllers/transactions_controller.dart';
import '../controllers/analytics_data.dart';
import '../providers/analytics_providers.dart';
import '../widgets/analytics_bar_chart.dart';
import '../widgets/analytics_empty_state.dart';
import '../widgets/analytics_shimmer.dart';
import '../widgets/analytics_statistics_section.dart';
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

  String _mapError(Object error) {
    if (error is DioException) {
      return error.apiException.userMessage;
    }
    if (error is ApiException) {
      return error.userMessage;
    }
    return 'Something went wrong. Please try again.';
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
          error: (error, _) => DashboardErrorView(
            message: _mapError(error),
            onRetry: _onRefresh,
          ),
          data: (state) {
            if (state.transactions.isEmpty) {
              return RefreshIndicator(
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

            return RefreshIndicator(
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
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('This Month', style: typography.title),
        const SectionSpacing.md(),
        Divider(color: colors.border, height: 1),
        const SectionSpacing.md(),
        _MonthTotalRow(
          label: 'Total Deposits',
          amount: data.totalDeposits,
        ),
        const SizedBox(height: AppSpacing.md),
        _MonthTotalRow(
          label: 'Total Withdrawals',
          amount: data.totalWithdrawals,
        ),
        const SectionSpacing.lg(),
        Divider(color: colors.border, height: 1),
        const SectionSpacing.lg(),
        AnalyticsSummaryCard(
          depositTotal: data.totalDeposits,
          depositCount: data.depositCount,
          withdrawalTotal: data.totalWithdrawals,
          withdrawalCount: data.withdrawCount,
        ),
        const SectionSpacing.lg(),
        Divider(color: colors.border, height: 1),
        const SectionSpacing.lg(),
        AnalyticsBarChart(
          depositTotal: data.totalDeposits,
          withdrawalTotal: data.totalWithdrawals,
        ),
        const SectionSpacing.lg(),
        Divider(color: colors.border, height: 1),
        const SectionSpacing.lg(),
        AnalyticsStatisticsSection(
          depositCount: data.depositCount,
          withdrawCount: data.withdrawCount,
          transferCount: data.transferCount,
        ),
        const SectionSpacing.lg(),
      ],
    );
  }
}

class _MonthTotalRow extends StatelessWidget {
  const _MonthTotalRow({
    required this.label,
    required this.amount,
  });

  final String label;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: typography.body),
        Text(
          CurrencyFormatter.format(amount),
          style: typography.title,
        ),
      ],
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
