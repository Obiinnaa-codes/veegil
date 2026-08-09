import '../constants/app_constants.dart';

abstract final class PhoneFormatter {
  static String mask(String phone) {
    if (phone.isEmpty) return phone;
    if (phone.length <= 3) return phone;

    final visibleDigits = phone.substring(phone.length - 3);
    final maskedLength = phone.length - 3;
    return '${'*' * maskedLength}$visibleDigits';
  }

  static String digitsOnly(String value) => value.replaceAll(RegExp(r'\D'), '');

  static String formatDisplay(String digits) {
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  static String limitDigits(String digits) {
    if (digits.length <= AppConstants.maxPhoneLength) return digits;
    return digits.substring(0, AppConstants.maxPhoneLength);
  }
}
