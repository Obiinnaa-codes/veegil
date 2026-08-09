import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_haptics.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/amount_input_field.dart';
import '../../../../shared/widgets/auth_gap.dart';
import '../../../../shared/widgets/auth_header.dart';
import '../../../../shared/widgets/inline_error_view.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../../../../shared/widgets/transaction_receipt_screen.dart';
import '../../../transactions/domain/entities/transaction_category.dart';
import '../../../transactions/presentation/utils/transaction_receipt_resolver.dart';
import '../controllers/deposit_controller.dart';
import '../controllers/deposit_state.dart';
import '../widgets/deposit_quick_amount_chips.dart';

class DepositScreen extends ConsumerStatefulWidget {
  const DepositScreen({super.key});

  @override
  ConsumerState<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends ConsumerState<DepositScreen> {
  final _amountFocusNode = FocusNode();

  @override
  void dispose() {
    _amountFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleDeposit() async {
    await ref.read(depositControllerProvider.notifier).deposit();
  }

  void _handleSuccess(DepositState state) {
    AppHaptics.success();

    final amount = state.depositedAmount;
    if (amount == null) return;

    final transaction = resolveReceiptTransaction(
      ref: ref,
      category: TransactionCategory.deposit,
      amount: amount.toDouble(),
    );

    showTransactionReceipt(
      context: context,
      transaction: transaction,
      onDone: () {
        if (mounted) {
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(depositControllerProvider, (previous, next) {
      final previousState = previous?.valueOrNull;
      final nextState = next.valueOrNull;

      if (nextState == null) return;

      if (nextState.status == DepositStatus.error &&
          nextState.errorMessage != null &&
          previousState?.errorMessage != nextState.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(nextState.errorMessage!)),
        );
      }

      if (nextState.status == DepositStatus.success &&
          previousState?.status != DepositStatus.success) {
        _handleSuccess(nextState);
      }
    });

    final depositState = ref.watch(depositControllerProvider);
    final controller = ref.read(depositControllerProvider.notifier);
    final state = depositState.valueOrNull ?? DepositState.initial;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit'),
      ),
      body: SafeArea(
        child: depositState.hasError
            ? Center(
                child: InlineErrorView(
                  message: 'Something went wrong. Please try again.',
                  onRetry: () =>
                      ref.invalidate(depositControllerProvider),
                ),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.dashboardHorizontalPadding(),
                  vertical: AppSpacing.md,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Responsive.dashboardMaxContentWidth(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AuthHeader(title: 'Deposit Money'),
                        const AuthGap.titleToContent(),
                        AmountInputField(
                          label: 'Amount',
                          hint: '₦0.00',
                          value: state.amountDisplay,
                          errorText: state.amountError,
                          focusNode: _amountFocusNode,
                          onChanged: controller.onAmountChanged,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        DepositQuickAmountChips(
                          selectedAmount: state.selectedQuickAmount,
                          onSelected: controller.setQuickAmount,
                        ),
                        const AuthGap.fieldToPrimaryButton(),
                        LoadingButton(
                          label: 'Deposit',
                          loadingLabel: 'Depositing...',
                          isLoading: state.isLoading,
                          isEnabled: !state.isLoading,
                          onPressed: _handleDeposit,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
