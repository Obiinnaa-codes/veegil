import 'package:intl/intl.dart';

abstract final class DateFormatter {
  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');

  static String format(DateTime? date) {
    if (date == null) return '—';
    return _dateFormat.format(date);
  }
}
