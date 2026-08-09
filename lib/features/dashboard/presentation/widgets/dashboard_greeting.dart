import 'package:flutter/material.dart';

import '../../../../core/utils/phone_formatter.dart';
import '../../../../core/theme/app_typography.dart';

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

  String _subtitle() {
    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      return PhoneFormatter.mask(phoneNumber!);
    }
    return 'Welcome Back';
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _greetingForTime(),
          style: typography.heading,
        ),
        const SizedBox(height: 4),
        Text(
          _subtitle(),
          style: typography.caption,
        ),
      ],
    );
  }
}
