import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_paths.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/secondary_button.dart';
import '../../../auth/presentation/providers/auth_repository_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final repository = ref.read(authRepositoryProvider);
    await repository.logout();
    if (context.mounted) {
      context.go(RoutePaths.login);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typography = context.typography;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Veegil Bank'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Home',
              style: typography.heading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
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
