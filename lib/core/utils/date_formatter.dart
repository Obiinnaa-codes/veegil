import 'package:intl/intl.dart';

abstract final class DateFormatter {
  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  static final DateFormat _timeFormat = DateFormat('h:mm a');
  static final DateFormat _memberSinceFormat = DateFormat('MMM yyyy');
  static final DateFormat _chartDayFormat = DateFormat('d MMM');

  static String formatChartDay(DateTime date) => _chartDayFormat.format(date);

  static String format(DateTime? date) {
    if (date == null) return '—';
    return _dateFormat.format(date);
  }

  static String formatTime(DateTime? date) {
    if (date == null) return '—';
    return _timeFormat.format(date);
  }

  static String formatMemberSince(DateTime? date) {
    if (date == null) return '';
    return _memberSinceFormat.format(date);
  }
}
