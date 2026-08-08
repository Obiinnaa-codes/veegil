import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/calendar_day_provider.dart';
import '../../../transactions/presentation/controllers/transactions_controller.dart';
import '../controllers/analytics_data.dart';

final analyticsDataProvider = Provider<AnalyticsData?>((ref) {
  final calendarDay = ref.watch(calendarDayProvider);
  final transactions = ref.watch(
    transactionsControllerProvider.select(
      (asyncState) => asyncState.valueOrNull?.transactions,
    ),
  );

  if (transactions == null) {
    return null;
  }

  return AnalyticsData.fromTransactions(
    transactions,
    referenceDate: calendarDay,
  );
});
