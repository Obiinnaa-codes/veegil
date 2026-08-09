import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class AuthSubmissionBanner extends StatelessWidget {
  const AuthSubmissionBanner({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Semantics(
      liveRegion: true,
      label: message,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppConstants.inputBorderRadius),
          border: Border.all(
            color: AppColors.error.withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.error_outline,
              size: 18,
              color: AppColors.error,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: typography.label.copyWith(
                  color: AppColors.error,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
