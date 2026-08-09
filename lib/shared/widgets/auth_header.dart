import 'package:flutter/material.dart';

import '../../core/theme/app_typography.dart';
import '../../core/theme/auth_spacing.dart';
import '../../core/utils/responsive.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.centerOnMobile = true,
  });

  final String title;
  final String? subtitle;
  final bool centerOnMobile;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final isCentered = centerOnMobile && !Responsive.isTablet(context);
    final textAlign = isCentered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: typography.heading,
          textAlign: textAlign,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AuthSpacing.labelToField),
          Text(
            subtitle!,
            style: typography.caption,
            textAlign: textAlign,
          ),
        ],
      ],
    );
  }
}
