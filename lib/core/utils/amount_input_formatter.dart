import 'package:flutter/services.dart';

import 'amount_parser.dart';

class AmountInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');
    if (digitsOnly.isEmpty) {
      return oldValue;
    }

    final parts = digitsOnly.split('.');
    if (parts.length > 2) {
      return oldValue;
    }

    if (parts.length == 2 && parts[1].length > 2) {
      return oldValue;
    }

    final parsed = double.tryParse(digitsOnly);
    if (parsed == null) {
      return oldValue;
    }

    final formatted = AmountParser.formatDisplay(parsed);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
