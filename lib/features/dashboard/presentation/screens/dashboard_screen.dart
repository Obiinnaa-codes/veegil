import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_paths.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/section_spacing.dart';
import '../../domain/entities/account.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/account_summary_card.dart';
import '../widgets/balance_card.dart';
import '../widgets/dashboard_error_view.dart';
import '../widgets/dashboard_greeting.dart';
import '../widgets/dashboard_shimmer.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/recent_transactions_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

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
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardControllerProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.person_outline),
          tooltip: 'Profile',
          onPressed: () => context.go(RoutePaths.profile),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Notifications',
            onPressed: () => context.push(RoutePaths.notifications),
          ),
        ],
      ),
      body: SafeArea(
        child: dashboardState.when(
          loading: () => _DashboardScrollContent(
            child: const DashboardShimmer(),
          ),
          error: (error, _) => DashboardErrorView(
            message: _mapError(error),
            onRetry: () =>
                ref.read(dashboardControllerProvider.notifier).refresh(),
          ),
          data: (account) => RefreshIndicator(
            onRefresh: () =>
                ref.read(dashboardControllerProvider.notifier).refresh(),
            child: _DashboardScrollContent(
              child: _DashboardBody(account: account),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardBody extends ConsumerWidget {
  const _DashboardBody({required this.account});

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshError = ref.watch(dashboardRefreshErrorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardGreeting(phoneNumber: account.phoneNumber),
        const SectionSpacing.lg(),
        BalanceCard(
          balance: account.balance,
          isLoading: false,
          errorMessage: refreshError,
          onRetry: () =>
              ref.read(dashboardControllerProvider.notifier).refresh(),
        ),
        const SectionSpacing.lg(),
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                label: 'Deposit',
                icon: Icons.add_circle_outline,
                onTap: () => context.push(RoutePaths.deposit),
              ),
            ),
            const SizedBox(width: DashboardSpacing.quickActionGap),
            Expanded(
              child: QuickActionCard(
                label: 'Withdraw',
                icon: Icons.remove_circle_outline,
                onTap: () => context.push(RoutePaths.withdraw),
              ),
            ),
            const SizedBox(width: DashboardSpacing.quickActionGap),
            Expanded(
              child: QuickActionCard(
                label: 'Transfer',
                icon: Icons.swap_horiz,
                onTap: () => context.push(RoutePaths.transfer),
              ),
            ),
          ],
        ),
        const SectionSpacing.lg(),
        const RecentTransactionsCard(),
        const SectionSpacing.lg(),
        AccountSummaryCard(account: account),
        const SectionSpacing.lg(),
      ],
    );
  }
}

class _DashboardScrollContent extends StatelessWidget {
  const _DashboardScrollContent({required this.child});

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
