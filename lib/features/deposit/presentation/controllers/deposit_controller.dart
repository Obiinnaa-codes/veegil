import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/amount_parser.dart';
import '../../../../core/utils/validators.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../dashboard/presentation/controllers/dashboard_controller.dart';
import '../../../transactions/presentation/controllers/transactions_controller.dart';
import '../../../transactions/presentation/providers/core_providers.dart';
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

      state = AsyncData(
        current.copyWith(
          status: DepositStatus.success,
          depositedAmount: amount,
          clearErrorMessage: true,
        ),
      );

      await ref.read(dashboardControllerProvider.notifier).refresh();
      await ref.read(transactionsControllerProvider.notifier).refresh();
      ref.invalidate(recentTransactionsProvider);
    } catch (error) {
      if (_isUnauthorized(error)) {
        await ref.read(authControllerProvider.notifier).logout();
        return;
      }

      state = AsyncData(
        current.copyWith(
          status: DepositStatus.error,
          errorMessage: _mapError(error),
        ),
      );
    }
  }

  bool _isUnauthorized(Object error) {
    if (error is DioException) {
      return error.response?.statusCode == 401 ||
          error.apiException.statusCode == 401;
    }
    if (error is ApiException) {
      return error.statusCode == 401;
    }
    return false;
  }

  String _mapError(Object error) {
    if (error is DioException) {
      return error.apiException.userMessage;
    }
    if (error is ApiException) {
      return error.userMessage;
    }
    return 'Something went wrong. Please try again.';
  }
}
