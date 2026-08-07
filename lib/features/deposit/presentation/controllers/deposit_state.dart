enum DepositStatus {
  idle,
  loading,
  success,
  error,
}

class DepositState {
  const DepositState({
    this.amountDisplay = '',
    this.amountError,
    this.status = DepositStatus.idle,
    this.errorMessage,
    this.depositedAmount,
    this.selectedQuickAmount,
  });

  final String amountDisplay;
  final String? amountError;
  final DepositStatus status;
  final String? errorMessage;
  final int? depositedAmount;
  final int? selectedQuickAmount;

  bool get isLoading => status == DepositStatus.loading;

  DepositState copyWith({
    String? amountDisplay,
    String? amountError,
    DepositStatus? status,
    String? errorMessage,
    int? depositedAmount,
    int? selectedQuickAmount,
    bool clearAmountError = false,
    bool clearErrorMessage = false,
    bool clearDepositedAmount = false,
    bool clearSelectedQuickAmount = false,
  }) {
    return DepositState(
      amountDisplay: amountDisplay ?? this.amountDisplay,
      amountError: clearAmountError ? null : (amountError ?? this.amountError),
      status: status ?? this.status,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      depositedAmount: clearDepositedAmount
          ? null
          : (depositedAmount ?? this.depositedAmount),
      selectedQuickAmount: clearSelectedQuickAmount
          ? null
          : (selectedQuickAmount ?? this.selectedQuickAmount),
    );
  }

  static const initial = DepositState();
}
