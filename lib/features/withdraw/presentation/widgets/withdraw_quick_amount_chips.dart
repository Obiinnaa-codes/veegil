import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/quick_amount_chips.dart';

class WithdrawQuickAmountChips extends StatelessWidget {
  const WithdrawQuickAmountChips({
    super.key,
    required this.selectedAmount,
    required this.onSelected,
    required this.onMaxPressed,
    this.isMaxSelected = false,
  });

  static const amounts = [500, 1000, 5000, 10000];

  final int? selectedAmount;
  final ValueChanged<int> onSelected;
  final VoidCallback onMaxPressed;
  final bool isMaxSelected;

  @override
  Widget build(BuildContext context) {
    return QuickAmountChips(
      amounts: amounts,
      selectedAmount: selectedAmount,
      onSelected: onSelected,
      accentColor: AppColors.transactionWithdraw,
      onMaxPressed: onMaxPressed,
      isMaxSelected: isMaxSelected,
    );
  }
}
