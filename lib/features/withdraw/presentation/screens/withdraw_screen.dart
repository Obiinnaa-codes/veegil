import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/amount_input_field.dart';
import '../../../../shared/widgets/auth_gap.dart';
import '../../../../shared/widgets/auth_header.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../../../../shared/widgets/operation_success_dialog.dart';
import '../controllers/withdraw_controller.dart';
import '../controllers/withdraw_state.dart';
import '../widgets/withdraw_quick_amount_chips.dart';

class WithdrawScreen extends ConsumerStatefulWidget {
  const WithdrawScreen({super.key});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  final _amountFocusNode = FocusNode();

  @override
  void dispose() {
    _amountFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleWithdraw() async {
    await ref.read(withdrawControllerProvider.notifier).withdraw();
  }

  void _handleSuccess(WithdrawState state) {
    final amount = state.withdrawnAmount;
    if (amount == null) return;

    showOperationSuccessDialog(
      context: context,
      title: 'Withdrawal Successful',
      message:
          '${CurrencyFormatter.format(amount.toDouble())} has been withdrawn from your account.',
      onDone: () {
        if (mounted) {
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(withdrawControllerProvider, (previous, next) {
      final previousState = previous?.valueOrNull;
      final nextState = next.valueOrNull;

      if (nextState == null) return;

      if (nextState.status == WithdrawStatus.error &&
          nextState.errorMessage != null &&
          previousState?.errorMessage != nextState.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(nextState.errorMessage!)),
        );
      }

      if (nextState.status == WithdrawStatus.success &&
          previousState?.status != WithdrawStatus.success) {
        _handleSuccess(nextState);
      }
    });

    final withdrawState = ref.watch(withdrawControllerProvider);
    final controller = ref.read(withdrawControllerProvider.notifier);
    final state = withdrawState.valueOrNull ?? WithdrawState.initial;

    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.transactionWithdraw,
            foregroundColor: AppColors.onPrimary,
            disabledBackgroundColor:
                AppColors.transactionWithdraw.withValues(alpha: 0.5),
            disabledForegroundColor: AppColors.onPrimary,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Withdraw'),
        ),
        body: SafeArea(
          child: withdrawState.hasError
              ? const Center(
                  child: Text('Something went wrong. Please try again.'),
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
                          const AuthHeader(title: 'Withdraw Money'),
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
                          WithdrawQuickAmountChips(
                            selectedAmount: state.selectedQuickAmount,
                            onSelected: controller.setQuickAmount,
                          ),
                          const AuthGap.fieldToPrimaryButton(),
                          LoadingButton(
                            label: 'Withdraw',
                            loadingLabel: 'Withdrawing...',
                            isLoading: state.isLoading,
                            isEnabled: !state.isLoading,
                            onPressed: _handleWithdraw,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
