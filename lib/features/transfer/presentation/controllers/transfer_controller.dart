import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/account_data_refresher.dart';
import '../../../../core/utils/amount_parser.dart';
import '../../../../core/utils/api_error_mapper.dart';
import '../../../../core/utils/validators.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../dashboard/presentation/controllers/dashboard_controller.dart';
import '../models/transfer_confirmation_details.dart';
import '../providers/core_providers.dart';
import 'transfer_state.dart';

final transferControllerProvider =
    AsyncNotifierProvider.autoDispose<TransferController, TransferState>(
  TransferController.new,
);

class TransferController extends AutoDisposeAsyncNotifier<TransferState> {
  static const _uuid = Uuid();

  @override
  Future<TransferState> build() async => TransferState.initial;

  void onPhoneChanged(String value) {
    final current = state.requireValue;
    state = AsyncData(
      current.copyWith(
        phoneNumber: value,
        clearPhoneError: true,
        status: TransferStatus.idle,
        clearErrorMessage: true,
        clearIdempotencyKey: true,
      ),
    );
  }

  void onAmountChanged(String value) {
    final current = state.requireValue;
    state = AsyncData(
      current.copyWith(
        amountDisplay: value,
        clearAmountError: true,
        clearSelectedQuickAmount: true,
        status: TransferStatus.idle,
        clearErrorMessage: true,
        clearIdempotencyKey: true,
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
        status: TransferStatus.idle,
        clearErrorMessage: true,
        clearIdempotencyKey: true,
      ),
    );
  }

  TransferConfirmationDetails? buildConfirmationDetails() {
    final current = state.requireValue;

    final trimmedPhone = current.phoneNumber.trim();
    final phoneError = Validators.phone(trimmedPhone);

    if (phoneError != null) {
      state = AsyncData(
        current.copyWith(
          phoneError: phoneError,
          status: TransferStatus.idle,
        ),
      );
      return null;
    }

    final currentUserPhone =
        ref.read(dashboardControllerProvider).valueOrNull?.phoneNumber;
    final selfTransferError =
        Validators.notSelfPhone(trimmedPhone, currentUserPhone);

    if (selfTransferError != null) {
      state = AsyncData(
        current.copyWith(
          phoneError: selfTransferError,
          status: TransferStatus.idle,
        ),
      );
      return null;
    }

    final amount = AmountParser.parseToNairaInt(current.amountDisplay);
    final amountError = Validators.amount(amount);

    if (amountError != null) {
      state = AsyncData(
        current.copyWith(
          amountError: amountError,
          status: TransferStatus.idle,
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
          status: TransferStatus.idle,
        ),
      );
      return null;
    }

    final balanceError = Validators.insufficientBalance(amount!, balance);
    if (balanceError != null) {
      state = AsyncData(
        current.copyWith(
          amountError: balanceError,
          status: TransferStatus.idle,
        ),
      );
      return null;
    }

    return TransferConfirmationDetails(
      recipientPhone: trimmedPhone,
      amount: amount,
      balance: balance,
    );
  }

  Future<void> transfer() async {
    final current = state.requireValue;
    if (current.isLoading) return;

    final details = buildConfirmationDetails();
    if (details == null) return;

    final trimmedPhone = details.recipientPhone;
    final amount = details.amount;
    final idempotencyKey =
        current.idempotencyKey ?? _uuid.v4();

    state = AsyncData(
      current.copyWith(
        status: TransferStatus.loading,
        clearErrorMessage: true,
        idempotencyKey: idempotencyKey,
      ),
    );

    try {
      await ref.read(transferRepositoryProvider).transfer(
            phoneNumber: trimmedPhone,
            amount: amount,
            idempotencyKey: idempotencyKey,
          );

      state = AsyncData(
        current.copyWith(
          status: TransferStatus.success,
          transferredAmount: amount,
          recipientPhoneNumber: trimmedPhone,
          clearErrorMessage: true,
          clearIdempotencyKey: true,
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
          status: TransferStatus.error,
          errorMessage: ApiErrorMapper.mapError(error),
          idempotencyKey: idempotencyKey,
        ),
      );
    }
  }
}
