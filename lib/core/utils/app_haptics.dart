import 'package:flutter/services.dart';

abstract final class AppHaptics {
  static void success() {
    HapticFeedback.mediumImpact();
  }
}
