import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Decorative circles for [PrimaryCardBackground]. Must be placed inside a
/// bounded [Stack] (e.g. via [Positioned.fill]).
class PrimaryCardCirclePattern extends StatelessWidget {
  const PrimaryCardCirclePattern({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -24,
          right: -16,
          child: _Circle(size: 120, alpha: 0.12),
        ),
        Positioned(
          bottom: -32,
          left: -24,
          child: _Circle(size: 96, alpha: 0.08),
        ),
      ],
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({
    required this.size,
    required this.alpha,
  });

  final double size;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: alpha),
        shape: BoxShape.circle,
      ),
    );
  }
}
