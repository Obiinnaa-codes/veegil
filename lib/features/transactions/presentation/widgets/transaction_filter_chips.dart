import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/transaction_filter.dart';

class TransactionFilterChips extends StatelessWidget {
  const TransactionFilterChips({
    super.key,
    required this.activeFilter,
    required this.onFilterChanged,
  });

  final TransactionFilter activeFilter;
  final ValueChanged<TransactionFilter> onFilterChanged;

  static const _filters = <TransactionFilter, String>{
    TransactionFilter.all: 'All',
    TransactionFilter.deposit: 'Deposits',
    TransactionFilter.withdraw: 'Withdrawals',
    TransactionFilter.transfer: 'Transfers',
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters.entries.map((entry) {
          final isSelected = activeFilter == entry.key;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(entry.value),
              selected: isSelected,
              showCheckmark: false,
              selectedColor: AppColors.primary,
              backgroundColor: colors.surfaceContainerHigh,
              labelStyle: TextStyle(
                color: isSelected ? colorScheme.onPrimary : colors.text,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              side: BorderSide(
                color:
                    isSelected ? AppColors.primary : colors.outlineVariant,
              ),
              onSelected: (_) => onFilterChanged(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}
