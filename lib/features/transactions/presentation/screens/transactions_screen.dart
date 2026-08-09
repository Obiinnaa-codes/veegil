import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/inline_error_view.dart';
import '../../../../shared/widgets/veegil_loading_indicator.dart';
import '../../../../shared/widgets/veegil_refresh_indicator.dart';
import '../../../dashboard/presentation/widgets/dashboard_error_view.dart';
import '../../../dashboard/presentation/widgets/dashboard_shimmer.dart';
import '../controllers/transactions_controller.dart';
import '../controllers/transactions_state.dart';
import '../../domain/entities/transaction_filter.dart';
import '../utils/transaction_receipt_navigation.dart';
import '../widgets/transaction_filter_chips.dart';
import '../widgets/transaction_item.dart';
import '../widgets/transactions_empty_state.dart';
import '../widgets/transactions_shimmer.dart';
import '../widgets/transactions_weekly_chart_card.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  final _scrollController = ScrollController();
  var _isLoadingAllTransactions = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(_ensureAllTransactionsLoaded);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _ensureAllTransactionsLoaded() async {
    if (_isLoadingAllTransactions || !mounted) return;

    _isLoadingAllTransactions = true;
    try {
      final notifier = ref.read(transactionsControllerProvider.notifier);
      while (mounted) {
        final state = ref.read(transactionsControllerProvider).valueOrNull;
        if (state == null || state.meta?.hasMore != true) break;
        await notifier.loadMore();
      }
    } finally {
      if (mounted) {
        _isLoadingAllTransactions = false;
      }
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      ref.read(transactionsControllerProvider.notifier).loadMore();
    }
  }

  Future<void> _onRefresh() async {
    await ref.read(transactionsControllerProvider.notifier).refresh();
    await _ensureAllTransactionsLoaded();
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

  @override
  Widget build(BuildContext context) {
    final transactionsState = ref.watch(transactionsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: SafeArea(
        child: transactionsState.when(
          loading: () => _TransactionsScrollContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ShimmerBox(
                  width: double.infinity,
                  height: 260,
                  borderRadius: AppConstants.cardBorderRadius,
                ),
                const SizedBox(height: AppSpacing.md),
                const TransactionsShimmer(),
              ],
            ),
          ),
          error: (error, _) => DashboardErrorView(
            message: _mapError(error),
            onRetry: () =>
                ref.read(transactionsControllerProvider.notifier).refresh(),
          ),
          data: (state) => VeegilRefreshIndicator(
            onRefresh: _onRefresh,
            child: _TransactionsScrollContent(
              controller: _scrollController,
              child: _TransactionsBody(state: state),
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionsBody extends ConsumerWidget {
  const _TransactionsBody({required this.state});

  final TransactionsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtered = state.filteredTransactions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TransactionsWeeklyChartCard(),
        const SizedBox(height: AppSpacing.md),
        TransactionFilterChips(
          activeFilter: state.activeFilter,
          onFilterChanged:
              ref.read(transactionsControllerProvider.notifier).setFilter,
        ),
        const SizedBox(height: AppSpacing.lg),
        if (filtered.isEmpty)
          TransactionsEmptyState(
            activeFilter: state.activeFilter,
            hasTransactions: state.transactions.isNotEmpty,
            onClearFilter: state.activeFilter == TransactionFilter.all
                ? null
                : () => ref
                    .read(transactionsControllerProvider.notifier)
                    .setFilter(TransactionFilter.all),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final transaction = filtered[index];
              return TransactionItem(
                transaction: transaction,
                onTap: () => showTransactionReceiptFromHistory(
                  context,
                  transaction,
                ),
              );
            },
          ),
        if (state.isLoadingMore) ...[
          const SizedBox(height: AppSpacing.lg),
          const Center(
            child: VeegilLoadingIndicator(
              size: 24,
            ),
          ),
        ],
        if (state.loadMoreErrorMessage != null) ...[
          const SizedBox(height: AppSpacing.md),
          InlineErrorView(
            message: state.loadMoreErrorMessage!,
            onRetry: () =>
                ref.read(transactionsControllerProvider.notifier).loadMore(),
            compact: true,
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

class _TransactionsScrollContent extends StatelessWidget {
  const _TransactionsScrollContent({
    required this.child,
    this.controller,
  });

  final Widget child;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minContentHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight - AppSpacing.md * 2
            : 0.0;

        return SingleChildScrollView(
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.dashboardHorizontalPadding(),
            vertical: AppSpacing.md,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.dashboardMaxContentWidth(context),
                minHeight: minContentHeight,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
