import 'package:flutter/material.dart';

import '../../core/theme/app_color_extension.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class AuthFieldHint extends StatelessWidget {
  const AuthFieldHint({
    super.key,
    required this.text,
    this.validText,
    this.isValid = false,
    this.inactiveIcon = Icons.lock_outline,
  });

  final String text;
  final String? validText;
  final bool isValid;
  final IconData inactiveIcon;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;
    final iconColor = isValid ? AppColors.success : colors.subtitle;
    final textColor = isValid ? AppColors.success : colors.subtitle;
    final displayText = isValid ? (validText ?? text) : text;

    return Semantics(
      label: isValid ? '$displayText. Requirement met.' : displayText,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isValid ? Icons.check_circle_outline : inactiveIcon,
              key: ValueKey(isValid),
              size: 14,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: typography.label.copyWith(color: textColor),
              child: Text(displayText),
            ),
          ),
        ],
      ),
    );
  }
}
