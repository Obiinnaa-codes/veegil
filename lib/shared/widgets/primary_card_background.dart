import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import 'primary_card_circle_pattern.dart';

class PrimaryCardBackground extends StatelessWidget {
  const PrimaryCardBackground({
    super.key,
    required this.child,
    this.borderRadius = AppConstants.cardBorderRadius,
    this.showPattern = true,
  });

  final Widget child;
  final double borderRadius;
  final bool showPattern;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            if (showPattern)
              const Positioned.fill(
                child: IgnorePointer(
                  child: PrimaryCardCirclePattern(),
                ),
              ),
            child,
          ],
        ),
      ),
    );
  }
}
