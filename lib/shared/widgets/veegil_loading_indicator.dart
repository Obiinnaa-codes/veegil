import 'package:flutter/material.dart';
import 'package:material3_expressive_loading_indicator/material3_expressive_loading_indicator.dart';

import '../../core/theme/app_colors.dart';

/// Material 3 expressive loading indicator used across Veegil.
class VeegilLoadingIndicator extends StatelessWidget {
  const VeegilLoadingIndicator({
    super.key,
    this.size = 24,
    this.color,
    this.outlined = false,
    this.strokeWidth,
  });

  const VeegilLoadingIndicator.small({
    super.key,
    this.color,
    this.outlined = true,
    this.strokeWidth = 2,
  }) : size = 20;

  final double size;
  final Color? color;
  final bool outlined;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorColor = color ?? theme.colorScheme.primary;

    return SizedBox(
      width: size,
      height: size,
      child: ExpressiveLoadingIndicator(
        color: indicatorColor,
        style: outlined
            ? ExpressiveLoadingIndicatorStyle.outlined
            : ExpressiveLoadingIndicatorStyle.filled,
        strokeWidth: strokeWidth,
        constraints: BoxConstraints(
          minWidth: size,
          minHeight: size,
          maxWidth: size,
          maxHeight: size,
        ),
      ),
    );
  }
}

/// Centered page-level expressive loader.
class VeegilPageLoader extends StatelessWidget {
  const VeegilPageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: VeegilLoadingIndicator(
        size: 48,
        color: AppColors.primary,
      ),
    );
  }
}
