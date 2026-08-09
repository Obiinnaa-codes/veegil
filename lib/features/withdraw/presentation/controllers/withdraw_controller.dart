import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/account_data_refresher.dart';
import '../../../../core/utils/amount_parser.dart';
import '../../../../core/utils/api_error_mapper.dart';
import '../../../../core/utils/validators.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../dashboard/presentation/controllers/dashboard_controller.dart';
import '../models/withdraw_confirmation_details.dart';
import '../providers/core_providers.dart';
import 'withdraw_state.dart';

final withdrawControllerProvider =
    AsyncNotifierProvider.autoDispose<WithdrawController, WithdrawState>(
  WithdrawController.new,
);

class WithdrawController extends AutoDisposeAsyncNotifier<WithdrawState> {
  @override
  Future<WithdrawState> build() async => WithdrawState.initial;

  void onAmountChanged(String value) {
    final current = state.requireValue;
    state = AsyncData(
      current.copyWith(
        amountDisplay: value,
        clearAmountError: true,
        clearSelectedQuickAmount: true,
        status: WithdrawStatus.idle,
        clearErrorMessage: true,
      ),
    );
  }

  void setQuickAmount(int amount) {
    final current = state.requireValue;
    state = AsyncData(
      current.copyWith(
        amountDisplay: AmountParser.formatDisplayFromInt(amount),
        selectedQuickAmount: amount,
        clearAmountError: true,
        status: WithdrawStatus.idle,
        clearErrorMessage: true,
      ),
    );
  }

  WithdrawConfirmationDetails? buildConfirmationDetails() {
    final current = state.requireValue;

    final amount = AmountParser.parseToNairaInt(current.amountDisplay);
    final amountError = Validators.amount(amount);

    if (amountError != null) {
      state = AsyncData(
        current.copyWith(
          amountError: amountError,
          status: WithdrawStatus.idle,
        ),
      );
      return null;
    }

    final balance =
        ref.read(dashboardControllerProvider).valueOrNull?.balance;
    if (balance == null) {
      state = AsyncData(
        current.copyWith(
          amountError:
              'Unable to verify your balance. Please go back and try again.',
          status: WithdrawStatus.idle,
        ),
      );
      return null;
    }

    final balanceError = Validators.insufficientBalance(amount!, balance);
    if (balanceError != null) {
      state = AsyncData(
        current.copyWith(
          amountError: balanceError,
          status: WithdrawStatus.idle,
        ),
      );
      return null;
    }

    return WithdrawConfirmationDetails(
      amount: amount,
      balance: balance,
    );
  }

  Future<void> withdraw() async {
    final current = state.requireValue;
    if (current.isLoading) return;

    final details = buildConfirmationDetails();
    if (details == null) return;

    final amount = details.amount;

    state = AsyncData(
      current.copyWith(
        status: WithdrawStatus.loading,
        clearErrorMessage: true,
      ),
    );

    try {
      await ref.read(withdrawRepositoryProvider).withdraw(amount);

      state = AsyncData(
        current.copyWith(
          status: WithdrawStatus.success,
          withdrawnAmount: amount,
          clearErrorMessage: true,
        ),
      );

      await refreshAccountData(ref);
    } catch (error) {
      if (ApiErrorMapper.isUnauthorized(error)) {
        await ref.read(authControllerProvider.notifier).logout();
        return;
      }

      state = AsyncData(
        current.copyWith(
          status: WithdrawStatus.error,
          errorMessage: ApiErrorMapper.mapError(error),
        ),
      );
    }
  }
}
