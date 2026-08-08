import 'package:flutter/material.dart';

import '../../../../core/theme/account_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/phone_formatter.dart';

class AccountInformationCard extends StatelessWidget {
  const AccountInformationCard({
    super.key,
    required this.phoneNumber,
    required this.memberSince,
  });

  final String phoneNumber;
  final DateTime? memberSince;

  @override
  Widget build(BuildContext context) {
    final rows = <_InfoRowData>[
      _InfoRowData(
        label: 'Phone Number',
        value: PhoneFormatter.mask(phoneNumber),
      ),
      // _InfoRowData(
      //   label: 'Member Since',
      //   value: DateFormatter.format(memberSince),
      // ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AccountSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AccountSpacing.cardBorderRadius),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) ...[
              const SizedBox(height: AppSpacing.md),
              const Divider(height: 1, thickness: 1, color: AppColors.border),
              const SizedBox(height: AppSpacing.md),
            ],
            _InfoRow(label: rows[i].label, value: rows[i].value),
          ],
        ],
      ),
    );
  }
}

class _InfoRowData {
  const _InfoRowData({required this.label, required this.value});

  final String label;
  final String value;
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: typography.caption),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: typography.body.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
