import 'package:intl/intl.dart';

abstract final class AmountParser {
  static final NumberFormat _nairaFormat = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 2,
  );

  static String formatDisplay(double amount) => _nairaFormat.format(amount);

  static String formatDisplayFromInt(int amount) => formatDisplay(amount.toDouble());

  static int? parseToNairaInt(String? display) {
    if (display == null || display.trim().isEmpty) {
      return null;
    }

    final digitsOnly = display.replaceAll(RegExp(r'[^\d.]'), '');
    if (digitsOnly.isEmpty) {
      return null;
    }

    final parsed = double.tryParse(digitsOnly);
    if (parsed == null) {
      return null;
    }

    return parsed.round();
  }

  static double? parseToDouble(String? display) {
    if (display == null || display.trim().isEmpty) {
      return null;
    }

    final digitsOnly = display.replaceAll(RegExp(r'[^\d.]'), '');
    if (digitsOnly.isEmpty) {
      return null;
    }

    return double.tryParse(digitsOnly);
  }
}
