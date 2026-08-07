import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/dashboard/presentation/controllers/dashboard_controller.dart';
import '../../features/transactions/presentation/controllers/transactions_controller.dart';
import '../../features/transactions/presentation/providers/core_providers.dart';

Future<void> refreshAccountData(Ref ref) async {
  await ref.read(dashboardControllerProvider.notifier).refresh();
  await ref.read(transactionsControllerProvider.notifier).refresh();
  ref.invalidate(recentTransactionsProvider);
}
