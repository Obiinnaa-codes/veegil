import '../../../../core/utils/currency_formatter.dart';

abstract final class AnalyticsFormatters {
  static String formatCompactAmount(double amount) {
    if (amount >= 1000000) {
      return '₦${(amount / 1000000).toStringAsFixed(1)}M';
    }
    if (amount >= 1000) {
      return '₦${(amount / 1000).toStringAsFixed(0)}K';
    }
    return '₦${amount.toStringAsFixed(0)}';
  }

  static ({double depositPct, double withdrawalPct})? depositWithdrawalPercentages(
    double deposits,
    double withdrawals,
  ) {
    final total = deposits + withdrawals;
    if (total <= 0) {
      return null;
    }

    final depositPct = (deposits / total) * 100;
    return (
      depositPct: depositPct,
      withdrawalPct: 100 - depositPct,
    );
  }

  static AnalyticsInsight buildInsight(double deposits, double withdrawals) {
    final difference = deposits - withdrawals;
    final absDifference = difference.abs();

    if (difference > 0) {
      return AnalyticsInsight(
        title: 'Great progress!',
        message:
            'Your deposits are higher than withdrawals by ${CurrencyFormatter.format(absDifference)}',
      );
    }

    if (difference < 0) {
      return AnalyticsInsight(
        title: 'Keep an eye on spending',
        message:
            'Your withdrawals are higher than deposits by ${CurrencyFormatter.format(absDifference)}',
      );
    }

    return const AnalyticsInsight(
      title: 'Balanced activity',
      message: 'Your deposits and withdrawals are balanced.',
    );
  }
}

class AnalyticsInsight {
  const AnalyticsInsight({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;
}
