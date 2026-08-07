import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/account.dart';

class AccountSummaryCard extends StatelessWidget {
  const AccountSummaryCard({
    super.key,
    required this.account,
  });

  final Account account;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Summary',
            style: typography.title,
          ),
          const SizedBox(height: AppSpacing.md),
          _SummaryRow(
            label: 'Phone Number',
            value: account.phoneNumber,
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: 'Account Created',
            value: DateFormatter.format(account.created),
          ),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: 'Available Balance',
            value: CurrencyFormatter.format(account.balance),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: typography.caption),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: typography.body.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
