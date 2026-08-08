import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Emits the current local calendar day and updates automatically at midnight.
final calendarDayProvider =
    NotifierProvider<CalendarDayController, DateTime>(CalendarDayController.new);

class CalendarDayController extends Notifier<DateTime> {
  Timer? _timer;

  @override
  DateTime build() {
    ref.onDispose(() => _timer?.cancel());
    _scheduleMidnightUpdate();
    return _today();
  }

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  void _scheduleMidnightUpdate() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final delay = nextMidnight.difference(now);

    _timer?.cancel();
    _timer = Timer(delay, () {
      state = _today();
      _scheduleMidnightUpdate();
    });
  }
}
