import 'package:flutter/material.dart';

import '../../../../core/theme/account_spacing.dart';
import '../../../../core/theme/app_color_extension.dart';
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
    final colors = context.appColors;
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
        color: colors.surface,
        borderRadius: BorderRadius.circular(AccountSpacing.cardBorderRadius),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) ...[
              const SizedBox(height: AppSpacing.md),
              Divider(height: 1, thickness: 1, color: colors.border),
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
