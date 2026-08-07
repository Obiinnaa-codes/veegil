import 'package:intl/intl.dart';

abstract final class CurrencyFormatter {
  static final NumberFormat _nairaFormat = NumberFormat.currency(
    locale: 'en_NG',
    symbol: '₦',
    decimalDigits: 2,
  );

  static String format(double amount) => _nairaFormat.format(amount);
}
