import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TransactionReceiptImageTheme {
  const TransactionReceiptImageTheme({
    required this.outerBackground,
    required this.receiptSurface,
    required this.primaryText,
    required this.secondaryText,
    required this.accentGreen,
    required this.detailsContainer,
    required this.divider,
    required this.typography,
  });

  final Color outerBackground;
  final Color receiptSurface;
  final Color primaryText;
  final Color secondaryText;
  final Color accentGreen;
  final Color detailsContainer;
  final Color divider;
  final AppTypography typography;

  factory TransactionReceiptImageTheme.fromBrightness(Brightness brightness) {
    if (brightness == Brightness.dark) {
      const colors = AppColorExtension.dark;
      final textTheme = AppTypography.createTextTheme(
        text: colors.text,
        subtitle: colors.subtitle,
      );

      return TransactionReceiptImageTheme(
        outerBackground: colors.background,
        receiptSurface: colors.surface,
        primaryText: colors.text,
        secondaryText: colors.subtitle,
        accentGreen: AppColors.primary,
        detailsContainer: colors.surfaceContainerHigh,
        divider: colors.outlineVariant,
        typography: AppTypography(textTheme),
      );
    }

    const primaryText = Color(0xFF10251F);
    const secondaryText = Color(0xFF6B7280);
    final textTheme = AppTypography.createTextTheme(
      text: primaryText,
      subtitle: secondaryText,
    );

    return TransactionReceiptImageTheme(
      outerBackground: const Color(0xFFF8FAFC),
      receiptSurface: const Color(0xFFFFFFFF),
      primaryText: primaryText,
      secondaryText: secondaryText,
      accentGreen: AppColors.primary,
      detailsContainer: const Color(0xFFF0F4F2),
      divider: const Color(0xFFD1D5DB),
      typography: AppTypography(textTheme),
    );
  }
}
