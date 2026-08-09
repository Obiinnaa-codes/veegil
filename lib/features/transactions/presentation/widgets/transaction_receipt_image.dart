import 'package:flutter/material.dart';

import '../../../../core/theme/account_spacing.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/transaction.dart';
import '../utils/transaction_colors.dart';
import '../utils/transaction_receipt_image_theme.dart';
import 'transaction_receipt_content.dart';

class TransactionReceiptImage extends StatelessWidget {
  const TransactionReceiptImage({
    super.key,
    required this.transaction,
    required this.theme,
  });

  final Transaction transaction;
  final TransactionReceiptImageTheme theme;

  static const double width = 360;

  @override
  Widget build(BuildContext context) {
    final typography = theme.typography;
    final accentColor =
        TransactionColors.forCategoryBrightness(transaction.category);

    return Container(
      width: width,
      color: theme.outerBackground,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AccountSpacing.cardPadding),
        decoration: BoxDecoration(
          color: theme.receiptSurface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'VEEGIL',
              style: typography.title.copyWith(
                color: theme.accentGreen,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Transaction Receipt',
              style: typography.caption.copyWith(
                color: theme.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AccountSpacing.sectionGap),
            TransactionReceiptSuccessSection(
              transaction: transaction,
              accentColor: accentColor,
              titleStyle: typography.title.copyWith(color: theme.primaryText),
              heroAmountStyle: typography.display.copyWith(
                color: accentColor,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
              descriptionStyle: typography.body.copyWith(
                color: theme.secondaryText,
              ),
            ),
            const SizedBox(height: AccountSpacing.sectionGap),
            Divider(
              height: 1,
              thickness: 1,
              color: theme.divider,
            ),
            const SizedBox(height: AccountSpacing.sectionGap),
            Text(
              'Transaction Details',
              style: typography.title.copyWith(color: theme.primaryText),
            ),
            const SizedBox(height: AppSpacing.md),
            TransactionReceiptDetailsCard(
              transaction: transaction,
              backgroundColor: theme.detailsContainer,
              borderColor: theme.divider,
              dividerColor: theme.divider,
              labelStyle: typography.caption.copyWith(color: theme.secondaryText),
              valueStyle: typography.body.copyWith(
                color: theme.primaryText,
                fontWeight: FontWeight.w500,
              ),
              showTooltip: false,
            ),
            const SizedBox(height: AccountSpacing.sectionGap),
            Divider(
              height: 1,
              thickness: 1,
              color: theme.divider,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Veegil',
              style: typography.body.copyWith(
                color: theme.accentGreen,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Secure digital banking',
              style: typography.caption.copyWith(color: theme.secondaryText),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
