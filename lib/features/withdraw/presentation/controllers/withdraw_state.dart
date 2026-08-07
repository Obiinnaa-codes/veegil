enum WithdrawStatus {
  idle,
  loading,
  success,
  error,
}

class WithdrawState {
  const WithdrawState({
    this.amountDisplay = '',
    this.amountError,
    this.status = WithdrawStatus.idle,
    this.errorMessage,
    this.withdrawnAmount,
    this.selectedQuickAmount,
  });

  final String amountDisplay;
  final String? amountError;
  final WithdrawStatus status;
  final String? errorMessage;
  final int? withdrawnAmount;
  final int? selectedQuickAmount;

  bool get isLoading => status == WithdrawStatus.loading;

  WithdrawState copyWith({
    String? amountDisplay,
    String? amountError,
    WithdrawStatus? status,
    String? errorMessage,
    int? withdrawnAmount,
    int? selectedQuickAmount,
    bool clearAmountError = false,
    bool clearErrorMessage = false,
    bool clearWithdrawnAmount = false,
    bool clearSelectedQuickAmount = false,
  }) {
    return WithdrawState(
      amountDisplay: amountDisplay ?? this.amountDisplay,
      amountError: clearAmountError ? null : (amountError ?? this.amountError),
      status: status ?? this.status,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      withdrawnAmount: clearWithdrawnAmount
          ? null
          : (withdrawnAmount ?? this.withdrawnAmount),
      selectedQuickAmount: clearSelectedQuickAmount
          ? null
          : (selectedQuickAmount ?? this.selectedQuickAmount),
    );
  }

  static const initial = WithdrawState();
}
