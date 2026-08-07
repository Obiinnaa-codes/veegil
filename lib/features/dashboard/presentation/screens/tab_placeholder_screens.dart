import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_paths.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/secondary_button.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class TransactionsPlaceholderScreen extends StatelessWidget {
  const TransactionsPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(
            'No transactions yet.',
            style: typography.body,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class ProfilePlaceholderScreen extends ConsumerWidget {
  const ProfilePlaceholderScreen({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    await ref.read(authControllerProvider.notifier).logout();
    if (context.mounted) {
      context.go(RoutePaths.login);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typography = context.typography;
    final user = ref.watch(authControllerProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (user != null) ...[
              Text(
                user.phoneNumber,
                style: typography.title,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Account holder',
                style: typography.caption,
              ),
            ],
            const Spacer(),
            SecondaryButton(
              label: 'Log Out',
              onPressed: () => _logout(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
