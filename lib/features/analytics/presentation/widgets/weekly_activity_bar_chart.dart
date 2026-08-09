import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/app_surface_card.dart';
import '../../../transactions/domain/entities/transaction_category.dart';
import '../../../transactions/presentation/utils/transaction_colors.dart';
import '../controllers/analytics_data.dart';

class WeeklyActivityBarChart extends StatelessWidget {
  const WeeklyActivityBarChart({
    super.key,
    required this.dailyActivity,
    this.title = 'Last 7 days',
    this.subtitle,
    this.compact = false,
    this.showChevron = false,
  });

  final List<DailyActivity> dailyActivity;
  final String title;
  final String? subtitle;
  final bool compact;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;
    final chartHeight = compact ? 160.0 : 220.0;
    final maxValue = dailyActivity.fold<double>(
      0,
      (max, day) {
        final dayMax = day.deposits > day.withdrawals
            ? day.deposits
            : day.withdrawals;
        return dayMax > max ? dayMax : max;
      },
    );
    final yMax = (maxValue > 0 ? maxValue : 1.0) * 1.2;

    return AppSurfaceCard(
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: typography.title),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(subtitle!, style: typography.caption),
                    ],
                  ],
                ),
              ),
              if (showChevron)
                Icon(
                  Icons.chevron_right,
                  color: colors.subtitle,
                  size: 20,
                ),
            ],
          ),
          SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
          SizedBox(
            height: chartHeight,
            child: BarChart(
              BarChartData(
                maxY: yMax,
                minY: 0,
                groupsSpace: compact ? 8 : 12,
                alignment: BarChartAlignment.spaceAround,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: yMax / 4,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: colors.border,
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= dailyActivity.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.sm),
                          child: Text(
                            DateFormatter.formatChartDay(
                              dailyActivity[index].date,
                            ),
                            style: typography.label,
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(dailyActivity.length, (index) {
                  final day = dailyActivity[index];
                  return BarChartGroupData(
                    x: index,
                    barsSpace: 4,
                    barRods: [
                      BarChartRodData(
                        toY: day.deposits,
                        width: compact ? 8 : 10,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                        color: TransactionColors.forCategory(
                          context,
                          TransactionCategory.deposit,
                        ),
                      ),
                      BarChartRodData(
                        toY: day.withdrawals,
                        width: compact ? 8 : 10,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                        color: TransactionColors.forCategory(
                          context,
                          TransactionCategory.withdraw,
                        ),
                      ),
                    ],
                  );
                }),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final day = dailyActivity[group.x];
                      final label = rodIndex == 0 ? 'Deposits' : 'Withdrawals';
                      final dateLabel = DateFormatter.formatChartDay(day.date);
                      return BarTooltipItem(
                        '$dateLabel\n$label\n${CurrencyFormatter.format(rod.toY)}',
                        typography.label.copyWith(color: colors.surface),
                      );
                    },
                  ),
                ),
              ),
              duration: Duration.zero,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _LegendItem(
                color: TransactionColors.forCategory(
                  context,
                  TransactionCategory.deposit,
                ),
                label: 'Deposits',
              ),
              const SizedBox(width: AppSpacing.lg),
              _LegendItem(
                color: TransactionColors.forCategory(
                  context,
                  TransactionCategory.withdraw,
                ),
                label: 'Withdrawals',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(label, style: typography.caption),
      ],
    );
  }
}
