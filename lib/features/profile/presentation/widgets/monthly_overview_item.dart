import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/account_spacing.dart';
import '../../../transactions/domain/entities/transaction_category.dart';
import '../../../transactions/presentation/utils/transaction_colors.dart';

class MonthlyOverviewItem extends StatelessWidget {
  const MonthlyOverviewItem({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.primaryValue,
    this.subtitle,
  });

  final String label;
  final IconData icon;
  final Color color;
  final String primaryValue;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;

    return Column(
      children: [
        Container(
          width: AccountSpacing.iconCircleSize,
          height: AccountSpacing.iconCircleSize,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: AccountSpacing.iconSize,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          label,
          style: typography.caption,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          primaryValue,
          style: typography.label.copyWith(
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            subtitle!,
            style: typography.label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

IconData iconForCategory(TransactionCategory category) {
  switch (category) {
    case TransactionCategory.deposit:
      return Icons.arrow_downward_rounded;
    case TransactionCategory.withdraw:
      return Icons.arrow_upward_rounded;
    case TransactionCategory.transfer:
      return Icons.swap_horiz_rounded;
    case TransactionCategory.unknown:
      return Icons.receipt_long_outlined;
  }
}

Color colorForCategory(BuildContext context, TransactionCategory category) {
  return TransactionColors.forCategory(context, category);
}

String transactionCountLabel(int count) {
  if (count == 1) return '1 transaction';
  return '$count transactions';
}

