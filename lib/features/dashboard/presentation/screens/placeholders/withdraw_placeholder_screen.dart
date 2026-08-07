import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

class WithdrawPlaceholderScreen extends StatelessWidget {
  const WithdrawPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(
            'Withdraw is coming soon.',
            style: typography.body,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
