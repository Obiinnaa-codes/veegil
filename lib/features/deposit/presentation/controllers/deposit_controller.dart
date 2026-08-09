import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/account_data_refresher.dart';
import '../../../../core/utils/amount_parser.dart';
import '../../../../core/utils/api_error_mapper.dart';
import '../../../../core/utils/validators.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../providers/core_providers.dart';
import 'deposit_state.dart';

final depositControllerProvider =
    AsyncNotifierProvider.autoDispose<DepositController, DepositState>(
  DepositController.new,
);

class DepositController extends AutoDisposeAsyncNotifier<DepositState> {
  @override
  Future<DepositState> build() async => DepositState.initial;

  void onAmountChanged(String value) {
    final current = state.requireValue;
    state = AsyncData(
      current.copyWith(
        amountDisplay: value,
        clearAmountError: true,
        clearSelectedQuickAmount: true,
        status: DepositStatus.idle,
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
        status: DepositStatus.idle,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> deposit() async {
    final current = state.requireValue;
    if (current.isLoading) return;

    final amount = AmountParser.parseToNairaInt(current.amountDisplay);
    final amountError = Validators.amount(amount);

    if (amountError != null) {
      state = AsyncData(
        current.copyWith(
          amountError: amountError,
          status: DepositStatus.idle,
        ),
      );
      return;
    }

    state = AsyncData(
      current.copyWith(
        status: DepositStatus.loading,
        clearErrorMessage: true,
      ),
    );

    try {
      await ref.read(depositRepositoryProvider).deposit(amount!);
      await refreshAccountData(ref);

      state = AsyncData(
        current.copyWith(
          status: DepositStatus.success,
          depositedAmount: amount,
          clearErrorMessage: true,
        ),
      );
    } catch (error) {
      if (ApiErrorMapper.isUnauthorized(error)) {
        await ref.read(authControllerProvider.notifier).logout();
        return;
      }

      state = AsyncData(
        current.copyWith(
          status: DepositStatus.error,
          errorMessage: ApiErrorMapper.mapError(error),
        ),
      );
    }
  }
}
