import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/account_spacing.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/phone_formatter.dart';
import '../../../../shared/widgets/primary_card_background.dart';

class HeroAccountCard extends StatelessWidget {
  const HeroAccountCard({
    super.key,
    required this.phoneNumber,
    this.memberSince,
  });

  final String phoneNumber;
  final DateTime? memberSince;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final memberSinceText = DateFormatter.formatMemberSince(memberSince);

    return PrimaryCardBackground(
      borderRadius: AccountSpacing.cardBorderRadius,
      child: Padding(
        padding: const EdgeInsets.all(AccountSpacing.cardPadding),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.onPrimary.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.onPrimary,
                size: 28,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    PhoneFormatter.mask(phoneNumber),
                    style: typography.title.copyWith(
                      color: AppColors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Verified Account',
                      style: typography.label.copyWith(
                        color: AppColors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (memberSinceText.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Member since $memberSinceText',
                      style: typography.caption.copyWith(
                        color: AppColors.onPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
