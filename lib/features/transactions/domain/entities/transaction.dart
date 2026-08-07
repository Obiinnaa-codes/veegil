import 'transaction_category.dart';
import 'transaction_direction.dart';

class Transaction {
  const Transaction({
    required this.id,
    required this.direction,
    required this.category,
    required this.amount,
    required this.phoneNumber,
    this.counterparty,
    this.balance,
    this.note,
    this.created,
  });

  final String id;
  final TransactionDirection direction;
  final TransactionCategory category;
  final double amount;
  final String phoneNumber;
  final String? counterparty;
  final double? balance;
  final String? note;
  final DateTime? created;
}
