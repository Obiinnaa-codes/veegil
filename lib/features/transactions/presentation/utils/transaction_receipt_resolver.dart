import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dashboard/presentation/controllers/dashboard_controller.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_category.dart';
import '../../domain/entities/transaction_direction.dart';
import '../controllers/transactions_controller.dart';

Transaction resolveReceiptTransaction({
  required WidgetRef ref,
  required TransactionCategory category,
  required double amount,
  String? counterparty,
}) {
  final transactions =
      ref.read(transactionsControllerProvider).valueOrNull?.transactions ?? [];

  final match = _findMatchingTransaction(
    transactions: transactions,
    category: category,
    amount: amount,
    counterparty: counterparty,
  );

  if (match != null) return match;

  final account = ref.read(dashboardControllerProvider).valueOrNull;

  return Transaction(
    id: '',
    direction: _directionForCategory(category),
    category: category,
    amount: amount,
    phoneNumber: account?.phoneNumber ?? '',
    counterparty: category == TransactionCategory.transfer ? counterparty : null,
    balance: account?.balance,
  );
}

Transaction? _findMatchingTransaction({
  required List<Transaction> transactions,
  required TransactionCategory category,
  required double amount,
  String? counterparty,
}) {
  Transaction? bestMatch;

  for (final transaction in transactions) {
    if (transaction.category != category) continue;
    if (transaction.amount != amount) continue;

    if (category == TransactionCategory.transfer &&
        counterparty != null &&
        counterparty.isNotEmpty) {
      final txCounterparty = transaction.counterparty;
      if (txCounterparty != null &&
          txCounterparty.isNotEmpty &&
          txCounterparty != counterparty) {
        continue;
      }
    }

    if (bestMatch == null) {
      bestMatch = transaction;
      continue;
    }

    final currentHasId = transaction.id.isNotEmpty;
    final bestHasId = bestMatch.id.isNotEmpty;
    if (currentHasId && !bestHasId) {
      bestMatch = transaction;
      continue;
    }
    if (!currentHasId && bestHasId) {
      continue;
    }

    final currentCreated = transaction.created;
    final bestCreated = bestMatch.created;
    if (currentCreated != null &&
        (bestCreated == null || currentCreated.isAfter(bestCreated))) {
      bestMatch = transaction;
    }
  }

  return bestMatch;
}

TransactionDirection _directionForCategory(TransactionCategory category) {
  switch (category) {
    case TransactionCategory.deposit:
      return TransactionDirection.credit;
    case TransactionCategory.withdraw:
    case TransactionCategory.transfer:
      return TransactionDirection.debit;
    case TransactionCategory.unknown:
      return TransactionDirection.unknown;
  }
}
