import '../../domain/entities/page_meta.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_category.dart';
import '../../domain/entities/transaction_filter.dart';

class TransactionsState {
  const TransactionsState({
    required this.transactions,
    this.meta,
    this.activeFilter = TransactionFilter.all,
    this.isLoadingMore = false,
    this.loadMoreErrorMessage,
  });

  final List<Transaction> transactions;
  final PageMeta? meta;
  final TransactionFilter activeFilter;
  final bool isLoadingMore;
  final String? loadMoreErrorMessage;

  List<Transaction> get filteredTransactions {
    return transactions.where(_matchesFilter).toList();
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

  TransactionsState copyWith({
    List<Transaction>? transactions,
    PageMeta? meta,
    TransactionFilter? activeFilter,
    bool? isLoadingMore,
    String? loadMoreErrorMessage,
    bool clearLoadMoreError = false,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      meta: meta ?? this.meta,
      activeFilter: activeFilter ?? this.activeFilter,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      loadMoreErrorMessage: clearLoadMoreError
          ? null
          : (loadMoreErrorMessage ?? this.loadMoreErrorMessage),
    );
  }
}
