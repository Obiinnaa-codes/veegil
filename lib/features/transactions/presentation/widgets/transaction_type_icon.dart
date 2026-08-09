import 'package:flutter/material.dart';

import '../../../../core/theme/account_spacing.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_category.dart';
import '../utils/transaction_colors.dart';

class TransactionTypeIcon extends StatelessWidget {
  const TransactionTypeIcon({
    super.key,
    required this.category,
    required this.color,
    this.icon,
    this.size = AccountSpacing.iconCircleSize,
    this.iconSize = AccountSpacing.iconSize,
    this.semanticLabel,
  });

  TransactionTypeIcon.forTransaction({
    super.key,
    required Transaction transaction,
    required this.color,
    this.size = AccountSpacing.iconCircleSize,
    this.iconSize = AccountSpacing.iconSize,
  })  : category = transaction.category,
        icon = TransactionColors.iconForTransaction(transaction),
        semanticLabel = TransactionColors.labelForCategory(
          transaction.category,
          note: transaction.note,
        );

  const TransactionTypeIcon.custom({
    super.key,
    required IconData this.icon,
    required this.color,
    this.size = AccountSpacing.iconCircleSize,
    this.iconSize = AccountSpacing.iconSize,
    this.semanticLabel,
  }) : category = TransactionCategory.unknown;

  final TransactionCategory category;
  final Color color;
  final IconData? icon;
  final double size;
  final double iconSize;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final resolvedIcon = icon ?? TransactionColors.iconForCategory(category);
    final label = semanticLabel ?? TransactionColors.labelForCategory(category);

    return Semantics(
      label: '$label transaction',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(
          resolvedIcon,
          color: color,
          size: iconSize,
        ),
      ),
    );
  }
}
