import 'package:flutter/services.dart';

import 'phone_formatter.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = PhoneFormatter.limitDigits(PhoneFormatter.digitsOnly(newValue.text));
    final formatted = PhoneFormatter.formatDisplay(digits);
    final digitIndex = _digitIndexIn(
      newValue.text,
      newValue.selection.baseOffset,
    );
    final selectionIndex = _formattedOffsetForDigitIndex(formatted, digitIndex);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: selectionIndex.clamp(0, formatted.length),
      ),
    );
  }

  static int _digitIndexIn(String text, int offset) {
    final safeOffset = offset.clamp(0, text.length);
    return PhoneFormatter.digitsOnly(text.substring(0, safeOffset)).length;
  }

  static int _formattedOffsetForDigitIndex(String formatted, int digitIndex) {
    if (digitIndex <= 0) return 0;

    var digitsSeen = 0;
    for (var i = 0; i < formatted.length; i++) {
      if (formatted[i] != ' ') {
        digitsSeen++;
      }
      if (digitsSeen >= digitIndex) {
        return i + 1;
      }
    }

    return formatted.length;
  }
}
