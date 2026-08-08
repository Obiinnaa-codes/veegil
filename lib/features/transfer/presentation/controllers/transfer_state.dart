enum TransferStatus {
  idle,
  loading,
  success,
  error,
}

class TransferState {
  const TransferState({
    this.phoneNumber = '',
    this.phoneError,
    this.amountDisplay = '',
    this.amountError,
    this.status = TransferStatus.idle,
    this.errorMessage,
    this.transferredAmount,
    this.recipientPhoneNumber,
    this.selectedQuickAmount,
    this.idempotencyKey,
  });

  final String phoneNumber;
  final String? phoneError;
  final String amountDisplay;
  final String? amountError;
  final TransferStatus status;
  final String? errorMessage;
  final int? transferredAmount;
  final String? recipientPhoneNumber;
  final int? selectedQuickAmount;
  final String? idempotencyKey;

  bool get isLoading => status == TransferStatus.loading;

  TransferState copyWith({
    String? phoneNumber,
    String? phoneError,
    String? amountDisplay,
    String? amountError,
    TransferStatus? status,
    String? errorMessage,
    int? transferredAmount,
    String? recipientPhoneNumber,
    int? selectedQuickAmount,
    String? idempotencyKey,
    bool clearPhoneError = false,
    bool clearAmountError = false,
    bool clearErrorMessage = false,
    bool clearTransferredAmount = false,
    bool clearRecipientPhoneNumber = false,
    bool clearSelectedQuickAmount = false,
    bool clearIdempotencyKey = false,
  }) {
    return TransferState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneError: clearPhoneError ? null : (phoneError ?? this.phoneError),
      amountDisplay: amountDisplay ?? this.amountDisplay,
      amountError: clearAmountError ? null : (amountError ?? this.amountError),
      status: status ?? this.status,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      transferredAmount: clearTransferredAmount
          ? null
          : (transferredAmount ?? this.transferredAmount),
      recipientPhoneNumber: clearRecipientPhoneNumber
          ? null
          : (recipientPhoneNumber ?? this.recipientPhoneNumber),
      selectedQuickAmount: clearSelectedQuickAmount
          ? null
          : (selectedQuickAmount ?? this.selectedQuickAmount),
      idempotencyKey:
          clearIdempotencyKey ? null : (idempotencyKey ?? this.idempotencyKey),
    );
  }

  static const initial = TransferState();
}
