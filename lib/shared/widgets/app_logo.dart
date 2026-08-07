import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Semantics(
      label: 'Veegil Bank',
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: typography.title.copyWith(fontWeight: FontWeight.w700),
          children: const [
            TextSpan(
              text: 'Veegil',
              style: TextStyle(color: AppColors.primary),
            ),
            TextSpan(
              text: ' Bank',
              style: TextStyle(color: AppColors.text),
            ),
          ],
        ),
      ),
    );
  }
}
