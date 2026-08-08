import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../transactions/presentation/controllers/transactions_controller.dart';
import '../controllers/analytics_data.dart';

final analyticsDataProvider = Provider<AnalyticsData?>((ref) {
  final transactions = ref.watch(
    transactionsControllerProvider.select(
      (asyncState) => asyncState.valueOrNull?.transactions,
    ),
  );

  if (transactions == null) {
    return null;
  }

  return AnalyticsData.fromTransactions(transactions);
});
