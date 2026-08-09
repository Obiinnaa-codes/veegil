class TransferConfirmationDetails {
  const TransferConfirmationDetails({
    required this.recipientPhone,
    required this.amount,
    required this.balance,
  });

  final String recipientPhone;
  final int amount;
  final double balance;

  double get balanceAfter => balance - amount;
}
