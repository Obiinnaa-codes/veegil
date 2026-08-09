import 'package:flutter/services.dart';

abstract final class AuthHapticFeedback {
  static void success() {
    HapticFeedback.lightImpact();
  }
}
