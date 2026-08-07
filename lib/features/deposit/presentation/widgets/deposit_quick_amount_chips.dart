import 'package:flutter/material.dart';

import '../../../../shared/widgets/quick_amount_chips.dart';

class DepositQuickAmountChips extends StatelessWidget {
  const DepositQuickAmountChips({
    super.key,
    required this.selectedAmount,
    required this.onSelected,
  });

  static const amounts = [500, 1000, 5000, 10000];

  final int? selectedAmount;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return QuickAmountChips(
      amounts: amounts,
      selectedAmount: selectedAmount,
      onSelected: onSelected,
    );
  }
}
