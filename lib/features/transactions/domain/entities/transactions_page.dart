import 'page_meta.dart';
import 'transaction.dart';

class TransactionsPage {
  const TransactionsPage({
    required this.items,
    required this.meta,
  });

  final List<Transaction> items;
  final PageMeta meta;
}
