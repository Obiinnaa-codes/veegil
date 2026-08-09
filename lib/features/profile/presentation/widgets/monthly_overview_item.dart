import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../transactions/presentation/widgets/transaction_type_icon.dart';

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
        TransactionTypeIcon.custom(
          icon: icon,
          color: color,
          semanticLabel: label,
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

String transactionCountLabel(int count) {
  if (count == 1) return '1 transaction';
  return '$count transactions';
}

