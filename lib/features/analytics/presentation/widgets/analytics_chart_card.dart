import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/dashboard_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/app_surface_card.dart';
import '../../../transactions/domain/entities/transaction_category.dart';
import '../../../transactions/presentation/utils/transaction_colors.dart';
import '../utils/analytics_formatters.dart';

class AnalyticsChartCard extends StatelessWidget {
  const AnalyticsChartCard({
    super.key,
    required this.depositTotal,
    required this.withdrawalTotal,
  });

  final double depositTotal;
  final double withdrawalTotal;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;
    final chartHeight = _chartHeight(context);
    final maxValue = [depositTotal, withdrawalTotal, 1.0].reduce(
      (value, element) => value > element ? value : element,
    );
    final yMax = maxValue * 1.25;
    final percentages = AnalyticsFormatters.depositWithdrawalPercentages(
      depositTotal,
      withdrawalTotal,
    );
    final depositColor = TransactionColors.forCategory(
      context,
      TransactionCategory.deposit,
    );
    final withdrawalColor = TransactionColors.forCategory(
      context,
      TransactionCategory.withdraw,
    );

    return AppSurfaceCard(
      useContainerHigh: false,
      padding: const EdgeInsets.all(DashboardSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deposits vs Withdrawals',
            style: typography.title,
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: chartHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                BarChart(
                  BarChartData(
                    maxY: yMax,
                    minY: 0,
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
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 56,
                          interval: yMax / 4,
                          getTitlesWidget: (value, meta) {
                            if (value < 0 || value > meta.max) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(right: AppSpacing.xs),
                              child: Text(
                                AnalyticsFormatters.formatCompactAmount(value),
                                style: typography.label,
                                textAlign: TextAlign.right,
                              ),
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
                            width: 48,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                            color: depositColor,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: withdrawalTotal,
                            width: 48,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                            color: withdrawalColor,
                          ),
                        ],
                      ),
                    ],
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final label =
                              group.x == 0 ? 'Deposits' : 'Withdrawals';
                          return BarTooltipItem(
                            '$label\n${CurrencyFormatter.format(rod.toY)}',
                            typography.label.copyWith(color: colors.surface),
                          );
                        },
                      ),
                    ),
                  ),
                  duration: Duration.zero,
                ),
                Positioned(
                  left: 56,
                  right: 0,
                  top: 0,
                  bottom: 28,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final chartAreaHeight = constraints.maxHeight;
                      final barAreaWidth = constraints.maxWidth;
                      final halfWidth = barAreaWidth / 2;

                      return Stack(
                        children: [
                          _BarValueLabel(
                            left: 0,
                            width: halfWidth,
                            bottom: _barLabelBottom(
                              depositTotal,
                              yMax,
                              chartAreaHeight,
                            ),
                            label: CurrencyFormatter.format(depositTotal),
                            style: typography.label.copyWith(
                              fontWeight: FontWeight.w600,
                              color: depositColor,
                            ),
                          ),
                          _BarValueLabel(
                            left: halfWidth,
                            width: halfWidth,
                            bottom: _barLabelBottom(
                              withdrawalTotal,
                              yMax,
                              chartAreaHeight,
                            ),
                            label: CurrencyFormatter.format(withdrawalTotal),
                            style: typography.label.copyWith(
                              fontWeight: FontWeight.w600,
                              color: withdrawalColor,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _LegendItem(
                color: depositColor,
                label: 'Deposits',
                percentage: percentages?.depositPct,
              ),
              const SizedBox(width: AppSpacing.lg),
              _LegendItem(
                color: withdrawalColor,
                label: 'Withdrawals',
                percentage: percentages?.withdrawalPct,
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _chartHeight(BuildContext context) {
    if (Responsive.isTablet(context)) {
      return 260;
    }
    return 220;
  }

  double _barLabelBottom(double value, double yMax, double chartHeight) {
    if (yMax <= 0) {
      return 4;
    }
    final barHeight = (value / yMax) * chartHeight;
    return barHeight + 6;
  }
}

class _BarValueLabel extends StatelessWidget {
  const _BarValueLabel({
    required this.left,
    required this.width,
    required this.bottom,
    required this.label,
    required this.style,
  });

  final double left;
  final double width;
  final double bottom;
  final String label;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      bottom: bottom,
      width: width,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: Text(
            label,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    this.percentage,
  });

  final Color color;
  final String label;
  final double? percentage;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final percentageLabel = percentage != null
        ? ' ${percentage!.toStringAsFixed(1)}%'
        : '';

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
        Text(
          '$label$percentageLabel',
          style: typography.caption,
        ),
      ],
    );
  }
}
