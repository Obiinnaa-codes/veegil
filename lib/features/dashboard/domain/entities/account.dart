class Account {
  const Account({
    required this.phoneNumber,
    required this.balance,
    this.created,
  });

  final String phoneNumber;
  final double balance;
  final DateTime? created;
}
