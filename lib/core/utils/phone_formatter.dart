abstract final class PhoneFormatter {
  static String mask(String phone) {
    if (phone.isEmpty) return phone;
    if (phone.length <= 3) return phone;

    final visibleDigits = phone.substring(phone.length - 3);
    final maskedLength = phone.length - 3;
    return '${'*' * maskedLength}$visibleDigits';
  }
}
