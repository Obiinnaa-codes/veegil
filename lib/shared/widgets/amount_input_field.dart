import 'package:flutter/material.dart';

import '../../core/utils/amount_input_formatter.dart';
import 'app_text_field.dart';

class AmountInputField extends StatelessWidget {
  const AmountInputField({
    super.key,
    required this.label,
    this.hint,
    this.value,
    this.errorText,
    this.onChanged,
    this.focusNode,
  });

  final String label;
  final String? hint;
  final String? value;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      hint: hint,
      value: value,
      errorText: errorText,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textInputAction: TextInputAction.done,
      inputFormatters: [AmountInputFormatter()],
      focusNode: focusNode,
      onChanged: onChanged,
    );
  }
}
