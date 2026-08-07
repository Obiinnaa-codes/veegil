import '../../domain/entities/page_meta.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_category.dart';
import '../../domain/entities/transaction_filter.dart';

class TransactionsState {
  const TransactionsState({
    required this.transactions,
    this.meta,
    this.activeFilter = TransactionFilter.all,
    this.searchQuery = '',
    this.isLoadingMore = false,
  });

  final List<Transaction> transactions;
  final PageMeta? meta;
  final TransactionFilter activeFilter;
  final String searchQuery;
  final bool isLoadingMore;

  List<Transaction> get filteredTransactions {
    return transactions.where(_matchesFilter).where(_matchesSearch).toList();
  }

  bool _matchesFilter(Transaction transaction) {
    switch (activeFilter) {
      case TransactionFilter.all:
        return true;
      case TransactionFilter.deposit:
        return transaction.category == TransactionCategory.deposit;
      case TransactionFilter.withdraw:
        return transaction.category == TransactionCategory.withdraw;
      case TransactionFilter.transfer:
        return transaction.category == TransactionCategory.transfer;
    }
  }

  bool _matchesSearch(Transaction transaction) {
    if (searchQuery.trim().isEmpty) return true;

    final query = searchQuery.trim().toLowerCase();
    final fields = <String>[
      transaction.note ?? '',
      transaction.counterparty ?? '',
      transaction.phoneNumber,
      transaction.amount.toString(),
      transaction.id,
    ];

    return fields.any((field) => field.toLowerCase().contains(query));
  }

  TransactionsState copyWith({
    List<Transaction>? transactions,
    PageMeta? meta,
    TransactionFilter? activeFilter,
    String? searchQuery,
    bool? isLoadingMore,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      meta: meta ?? this.meta,
      activeFilter: activeFilter ?? this.activeFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
