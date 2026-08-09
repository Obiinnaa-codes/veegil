import 'package:flutter/material.dart';

import '../../core/theme/app_color_extension.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class InlineErrorView extends StatelessWidget {
  const InlineErrorView({
    super.key,
    required this.message,
    required this.onRetry,
    this.retryLabel = 'Try Again',
    this.compact = false,
  });

  final String message;
  final VoidCallback onRetry;
  final String retryLabel;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final colors = context.appColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.cloud_off_outlined,
          size: compact ? 32 : 40,
          color: colors.subtitle,
        ),
        SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
        Text(
          message,
          style: compact ? typography.caption : typography.body,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
        TextButton(
          onPressed: onRetry,
          child: Text(retryLabel),
        ),
      ],
    );
  }
}
