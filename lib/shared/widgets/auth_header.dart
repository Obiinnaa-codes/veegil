import 'package:flutter/material.dart';

import '../../core/theme/app_typography.dart';
import '../../core/theme/auth_spacing.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: typography.heading,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AuthSpacing.labelToField),
          Text(
            subtitle!,
            style: typography.caption,
          ),
        ],
      ],
    );
  }
}
