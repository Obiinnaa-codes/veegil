class WithdrawConfirmationDetails {
  const WithdrawConfirmationDetails({
    required this.amount,
    required this.balance,
  });

  final int amount;
  final double balance;

  double get balanceAfter => balance - amount;
}
