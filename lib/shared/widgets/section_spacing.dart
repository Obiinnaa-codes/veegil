import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

class SectionSpacing extends StatelessWidget {
  const SectionSpacing.xs({super.key}) : height = AppSpacing.xs;
  const SectionSpacing.sm({super.key}) : height = AppSpacing.sm;
  const SectionSpacing.md({super.key}) : height = AppSpacing.md;
  const SectionSpacing.lg({super.key}) : height = AppSpacing.lg;
  const SectionSpacing.xl({super.key}) : height = AppSpacing.xl;
  const SectionSpacing.xxl({super.key}) : height = AppSpacing.xxl;

  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}
