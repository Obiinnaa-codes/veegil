import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

class ShimmerBox extends StatefulWidget {
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1 + _controller.value * 2, 0),
              end: Alignment(1 + _controller.value * 2, 0),
              colors: const [
                AppColors.border,
                AppColors.surface,
                AppColors.border,
              ],
            ),
          ),
        );
      },
    );
  }
}

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ShimmerBox(width: 160, height: 28),
        const SizedBox(height: AppSpacing.sm),
        const ShimmerBox(width: 120, height: 16),
        const SizedBox(height: AppSpacing.lg),
        ShimmerBox(
          width: double.infinity,
          height: 140,
          borderRadius: AppSpacing.md,
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: ShimmerBox(
                width: double.infinity,
                height: 88,
                borderRadius: AppSpacing.md,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ShimmerBox(
                width: double.infinity,
                height: 88,
                borderRadius: AppSpacing.md,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ShimmerBox(
                width: double.infinity,
                height: 88,
                borderRadius: AppSpacing.md,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        ShimmerBox(
          width: double.infinity,
          height: 120,
          borderRadius: AppSpacing.md,
        ),
      ],
    );
  }
}
