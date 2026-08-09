import 'package:flutter/material.dart';

import '../../../../core/theme/app_typography.dart';
import '../../../profile/presentation/widgets/revealable_account_value.dart';

class DashboardGreeting extends StatelessWidget {
  const DashboardGreeting({
    super.key,
    required this.phoneNumber,
  });

  final String? phoneNumber;

  String _greetingForTime() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final hasPhone = phoneNumber != null && phoneNumber!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _greetingForTime(),
          style: typography.heading,
        ),
        const SizedBox(height: 4),
        if (hasPhone)
          RevealableAccountValue(
            value: phoneNumber!,
            style: typography.caption,
          )
        else
          Text(
            'Welcome Back',
            style: typography.caption,
          ),
      ],
    );
  }
}
