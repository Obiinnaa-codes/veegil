import 'package:flutter/material.dart';

import '../../core/theme/app_color_extension.dart';
import '../../core/theme/app_colors.dart';
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
    final colors = context.appColors;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: amounts.map((amount) {
          final isSelected = selectedAmount == amount;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(CurrencyFormatter.format(amount.toDouble())),
              selected: isSelected,
              showCheckmark: false,
              selectedColor: accentColor,
              backgroundColor: colors.surfaceContainerHigh,
              labelStyle: TextStyle(
                color: isSelected ? colorScheme.onPrimary : colors.text,
              ),
              side: BorderSide(
                color: isSelected ? accentColor : colors.outlineVariant,
              ),
              onSelected: (_) => onSelected(amount),
            ),
          );
        }).toList(),
      ),
    );
  }
}
