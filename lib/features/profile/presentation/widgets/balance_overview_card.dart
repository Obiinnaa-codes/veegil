import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/account_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/widgets/app_surface_card.dart';
import '../../../analytics/presentation/controllers/analytics_data.dart';
import '../../../dashboard/presentation/widgets/dashboard_shimmer.dart';
import '../../../transactions/domain/entities/transaction_category.dart';
import '../../../transactions/presentation/utils/transaction_colors.dart';
import 'monthly_overview_item.dart';

class BalanceOverviewCard extends StatefulWidget {
  const BalanceOverviewCard({
    super.key,
    required this.balance,
    this.analyticsData,
    this.isLoadingOverview = false,
  });

  final double? balance;
  final AnalyticsData? analyticsData;
  final bool isLoadingOverview;

  @override
  State<BalanceOverviewCard> createState() => _BalanceOverviewCardState();
}

class _BalanceOverviewCardState extends State<BalanceOverviewCard> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;
    final balance = widget.balance;

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AccountSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Available Balance',
                  style: typography.caption,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'NGN',
                  style: typography.label.copyWith(
                    color: AppColors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() => _isBalanceVisible = !_isBalanceVisible);
                },
                icon: Icon(
                  _isBalanceVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: colors.subtitle,
                  size: AccountSpacing.iconSize,
                ),
                tooltip: _isBalanceVisible ? 'Hide balance' : 'Show balance',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            balance != null
                ? (_isBalanceVisible
                    ? CurrencyFormatter.format(balance)
                    : '••••••')
                : '—',
            style: typography.display,
          ),
          const SizedBox(height: AccountSpacing.sectionGap),
          Text('This Month Overview', style: typography.title),
          const SizedBox(height: AppSpacing.md),
          if (widget.isLoadingOverview && widget.analyticsData == null)
            const Row(
              children: [
                Expanded(child: ShimmerBox(width: double.infinity, height: 88)),
                SizedBox(width: AppSpacing.sm),
                Expanded(child: ShimmerBox(width: double.infinity, height: 88)),
                SizedBox(width: AppSpacing.sm),
                Expanded(child: ShimmerBox(width: double.infinity, height: 88)),
              ],
            )
          else
            _MonthlyOverviewRow(analyticsData: widget.analyticsData),
        ],
      ),
    );
  }
}

class _MonthlyOverviewRow extends StatelessWidget {
  const _MonthlyOverviewRow({this.analyticsData});

  final AnalyticsData? analyticsData;

  @override
  Widget build(BuildContext context) {
    final data = analyticsData;

    return Row(
      children: [
        Expanded(
          child: MonthlyOverviewItem(
            label: 'Deposits',
            icon: TransactionColors.iconForCategory(TransactionCategory.deposit),
            color: TransactionColors.forCategory(context, TransactionCategory.deposit),
            primaryValue: data != null
                ? CurrencyFormatter.format(data.totalDeposits)
                : '—',
            subtitle: data != null
                ? transactionCountLabel(data.depositCount)
                : null,
          ),
        ),
        Expanded(
          child: MonthlyOverviewItem(
            label: 'Withdrawals',
            icon: TransactionColors.iconForCategory(TransactionCategory.withdraw),
            color: TransactionColors.forCategory(context, TransactionCategory.withdraw),
            primaryValue: data != null
                ? CurrencyFormatter.format(data.totalWithdrawals)
                : '—',
            subtitle: data != null
                ? transactionCountLabel(data.withdrawCount)
                : null,
          ),
        ),
        Expanded(
          child: MonthlyOverviewItem(
            label: 'Transfers',
            icon: TransactionColors.iconForCategory(TransactionCategory.transfer),
            color: TransactionColors.forCategory(context, TransactionCategory.transfer),
            primaryValue: data != null ? '${data.transferCount}' : '—',
            subtitle: data != null
                ? transactionCountLabel(data.transferCount)
                : null,
          ),
        ),
      ],
    );
  }
}
