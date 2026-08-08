import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
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
    final typography = context.typography;
    final colors = context.appColors;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters.entries.map((entry) {
          final isSelected = activeFilter == entry.key;
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: FilterChip(
              label: Text(
                entry.value,
                style: typography.label.copyWith(
                  color: isSelected ? AppColors.onPrimary : colors.text,
                ),
              ),
              selected: isSelected,
              showCheckmark: false,
              selectedColor: AppColors.primary,
              backgroundColor: colors.surface,
              side: BorderSide(
                color: isSelected ? AppColors.primary : colors.border,
              ),
              onSelected: (_) => onFilterChanged(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}
