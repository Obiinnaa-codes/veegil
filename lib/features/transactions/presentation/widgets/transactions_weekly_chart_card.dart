import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_paths.dart';
import '../../../../core/theme/account_spacing.dart';
import '../../../analytics/presentation/providers/analytics_providers.dart';
import '../../../analytics/presentation/widgets/weekly_activity_bar_chart.dart';
import '../../../dashboard/presentation/widgets/dashboard_shimmer.dart';

class TransactionsWeeklyChartCard extends ConsumerWidget {
  const TransactionsWeeklyChartCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsData = ref.watch(analyticsDataProvider);

    if (analyticsData == null) {
      return const ShimmerBox(
        width: double.infinity,
        height: 260,
        borderRadius: AccountSpacing.cardBorderRadius,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(RoutePaths.analytics),
        borderRadius: BorderRadius.circular(AccountSpacing.cardBorderRadius),
        child: WeeklyActivityBarChart(
          dailyActivity: analyticsData.last7DaysDaily,
          title: 'Last 7 days',
          subtitle: 'Deposits and withdrawals — tap for full analytics',
          compact: true,
          showChevron: true,
        ),
      ),
    );
  }
}
