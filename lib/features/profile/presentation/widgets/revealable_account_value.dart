import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/phone_formatter.dart';
import '../controllers/profile_controller.dart';

class RevealableAccountValue extends ConsumerWidget {
  const RevealableAccountValue({
    super.key,
    required this.value,
    required this.style,
  });

  final String value;
  final TextStyle style;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(sensitiveAccountInfoVisibleProvider);
    final displayValue = isVisible ? value : PhoneFormatter.mask(value);

    return GestureDetector(
      onTap: () {
        ref.read(sensitiveAccountInfoVisibleProvider.notifier).state =
            !isVisible;
      },
      behavior: HitTestBehavior.opaque,
      child: Text(displayValue, style: style),
    );
  }
}
