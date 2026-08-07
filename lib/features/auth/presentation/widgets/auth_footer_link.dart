import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    super.key,
    required this.prompt,
    required this.actionLabel,
    required this.onTap,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final linkStyle = typography.caption.copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
    );

    return Semantics(
      link: true,
      label: '$prompt $actionLabel',
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 4,
        children: [
          Text(
            prompt,
            style: typography.caption,
          ),
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Text(
              actionLabel,
              style: linkStyle,
            ),
          ),
        ],
      ),
    );
  }
}
