import 'package:flutter/material.dart';

import '../../../../core/theme/account_spacing.dart';
import '../../../../core/theme/app_color_extension.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_surface_card.dart';
import 'revealable_account_value.dart';

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
    final typography = context.typography;

    final rows = <_InfoRowData>[
      _InfoRowData(label: 'Phone Number', value: phoneNumber),
      _InfoRowData(label: 'Account Number', value: phoneNumber),
    ];

    return AppSurfaceCard(
      padding: const EdgeInsets.all(AccountSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Account Information', style: typography.title),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) ...[
              const SizedBox(height: AppSpacing.md),
              Divider(height: 1, thickness: 1, color: colors.outlineVariant),
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
        RevealableAccountValue(
          value: value,
          style: typography.body.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
