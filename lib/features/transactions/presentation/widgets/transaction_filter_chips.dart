import 'package:flutter/material.dart';

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
              onSelected: (_) => onFilterChanged(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}
