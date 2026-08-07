import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';

class QuickAmountChips extends StatelessWidget {
  const QuickAmountChips({
    super.key,
    required this.amounts,
    required this.selectedAmount,
    required this.onSelected,
  });

  final List<int> amounts;
  final int? selectedAmount;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: amounts.map((amount) {
          final isSelected = selectedAmount == amount;
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilterChip(
              label: Text(
                CurrencyFormatter.format(amount.toDouble()),
                style: typography.label.copyWith(
                  color: isSelected ? AppColors.onPrimary : AppColors.text,
                ),
              ),
              selected: isSelected,
              showCheckmark: false,
              selectedColor: AppColors.primary,
              backgroundColor: AppColors.surface,
              side: BorderSide(
                color: isSelected ? AppColors.primary : AppColors.border,
              ),
              onSelected: (_) => onSelected(amount),
            ),
          );
        }).toList(),
      ),
    );
  }
}
