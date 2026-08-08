import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../transactions/presentation/utils/transaction_colors.dart';
import '../../../transactions/domain/entities/transaction_category.dart';

class AnalyticsBarChart extends StatelessWidget {
  const AnalyticsBarChart({
    super.key,
    required this.depositTotal,
    required this.withdrawalTotal,
  });

  final double depositTotal;
  final double withdrawalTotal;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final chartHeight = _chartHeight(context);
    final maxValue = [depositTotal, withdrawalTotal, 1.0].reduce(
      (value, element) => value > element ? value : element,
    );
    final yMax = maxValue * 1.2;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bar Chart', style: typography.title),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: chartHeight,
            child: BarChart(
              BarChartData(
                maxY: yMax,
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: yMax / 4,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.border,
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
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 52,
                      getTitlesWidget: (value, meta) {
                        if (value == 0 || value == meta.max) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          _formatAxisLabel(value),
                          style: typography.caption,
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return Padding(
                              padding: const EdgeInsets.only(top: AppSpacing.sm),
                              child: Text(
                                'Deposits',
                                style: typography.caption,
                              ),
                            );
                          case 1:
                            return Padding(
                              padding: const EdgeInsets.only(top: AppSpacing.sm),
                              child: Text(
                                'Withdrawals',
                                style: typography.caption,
                              ),
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: depositTotal,
                        width: 40,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6),
                        ),
                        color: TransactionColors.forCategory(
                          TransactionCategory.deposit,
                        ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: withdrawalTotal,
                        width: 40,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6),
                        ),
                        color: TransactionColors.forCategory(
                          TransactionCategory.withdraw,
                        ),
                      ),
                    ],
                  ),
                ],
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final label = group.x == 0 ? 'Deposits' : 'Withdrawals';
                      return BarTooltipItem(
                        '$label\n${CurrencyFormatter.format(rod.toY)}',
                        typography.label.copyWith(color: AppColors.surface),
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
                  TransactionCategory.deposit,
                ),
                label: 'Deposits',
              ),
              const SizedBox(width: AppSpacing.lg),
              _LegendItem(
                color: TransactionColors.forCategory(
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

  double _chartHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 600) {
      return 260;
    }
    return 220;
  }

  String _formatAxisLabel(double value) {
    if (value >= 1000000) {
      return '₦${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (value >= 1000) {
      return '₦${(value / 1000).toStringAsFixed(0)}K';
    }
    return '₦${value.toStringAsFixed(0)}';
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
