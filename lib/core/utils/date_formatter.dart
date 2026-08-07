import 'package:intl/intl.dart';

abstract final class DateFormatter {
  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  static final DateFormat _timeFormat = DateFormat('h:mm a');

  static String format(DateTime? date) {
    if (date == null) return '—';
    return _dateFormat.format(date);
  }

  static String formatTime(DateTime? date) {
    if (date == null) return '—';
    return _timeFormat.format(date);
  }
}
