import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

class DepositPlaceholderScreen extends StatelessWidget {
  const DepositPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(
            'Deposit is coming soon.',
            style: typography.body,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
