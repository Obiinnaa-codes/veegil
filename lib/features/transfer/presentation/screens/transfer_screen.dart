import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/amount_input_field.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/auth_gap.dart';
import '../../../../shared/widgets/auth_header.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../../../../shared/widgets/operation_success_dialog.dart';
import '../controllers/transfer_controller.dart';
import '../controllers/transfer_state.dart';
import '../widgets/transfer_quick_amount_chips.dart';

class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final _phoneFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleTransfer() async {
    await ref.read(transferControllerProvider.notifier).transfer();
  }

  void _handleSuccess(TransferState state) {
    final amount = state.transferredAmount;
    final recipient = state.recipientPhoneNumber;
    if (amount == null || recipient == null) return;

    showOperationSuccessDialog(
      context: context,
      title: 'Transfer Successful',
      details: [
        OperationSuccessDetail(label: 'Recipient', value: recipient),
        OperationSuccessDetail(
          label: 'Amount',
          value: CurrencyFormatter.format(amount.toDouble()),
        ),
      ],
      onDone: () {
        if (mounted) {
          context.pop();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(transferControllerProvider, (previous, next) {
      final previousState = previous?.valueOrNull;
      final nextState = next.valueOrNull;

      if (nextState == null) return;

      if (nextState.status == TransferStatus.error &&
          nextState.errorMessage != null &&
          previousState?.errorMessage != nextState.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(nextState.errorMessage!)),
        );
      }

      if (nextState.status == TransferStatus.success &&
          previousState?.status != TransferStatus.success) {
        _handleSuccess(nextState);
      }
    });

    final transferState = ref.watch(transferControllerProvider);
    final controller = ref.read(transferControllerProvider.notifier);
    final state = transferState.valueOrNull ?? TransferState.initial;

    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.transactionTransfer,
            foregroundColor: AppColors.onPrimary,
            disabledBackgroundColor:
                AppColors.transactionTransfer.withValues(alpha: 0.5),
            disabledForegroundColor: AppColors.onPrimary,
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transfer'),
        ),
        body: SafeArea(
          child: transferState.hasError
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
                          const AuthHeader(title: 'Transfer Money'),
                          const AuthGap.titleToContent(),
                          AppTextField(
                            label: 'Recipient Phone Number',
                            hint: '080xxxxxxxx',
                            value: state.phoneNumber,
                            errorText: state.phoneError,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            focusNode: _phoneFocusNode,
                            onChanged: controller.onPhoneChanged,
                            onSubmitted: (_) =>
                                _amountFocusNode.requestFocus(),
                          ),
                          const AuthGap.fieldToNextLabel(),
                          AmountInputField(
                            label: 'Amount',
                            hint: '₦0.00',
                            value: state.amountDisplay,
                            errorText: state.amountError,
                            focusNode: _amountFocusNode,
                            onChanged: controller.onAmountChanged,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          TransferQuickAmountChips(
                            selectedAmount: state.selectedQuickAmount,
                            onSelected: controller.setQuickAmount,
                          ),
                          const AuthGap.fieldToPrimaryButton(),
                          LoadingButton(
                            label: 'Transfer',
                            loadingLabel: 'Transferring...',
                            isLoading: state.isLoading,
                            isEnabled: !state.isLoading,
                            onPressed: _handleTransfer,
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
