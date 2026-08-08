import 'package:flutter/material.dart';

import '../../core/theme/app_color_extension.dart';
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
    this.accentColor = AppColors.primary,
  });

  final List<int> amounts;
  final int? selectedAmount;
  final ValueChanged<int> onSelected;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;

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
                  color: isSelected ? AppColors.onPrimary : colors.text,
                ),
              ),
              selected: isSelected,
              showCheckmark: false,
              selectedColor: accentColor,
              backgroundColor: colors.surface,
              side: BorderSide(
                color: isSelected ? accentColor : colors.border,
              ),
              onSelected: (_) => onSelected(amount),
            ),
          );
        }).toList(),
      ),
    );
  }
}
