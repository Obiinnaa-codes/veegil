import 'package:flutter/material.dart';

import '../../core/theme/app_color_extension.dart';
import '../../core/theme/app_shape_extension.dart';

/// Expressive M3 surface card used across the app.
class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius,
    this.useContainerHigh = true,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final bool useContainerHigh;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final shapes = context.appShapes;
    final radius = borderRadius ?? shapes.cardBorderRadius;
    final background =
        useContainerHigh ? colors.surfaceContainerHigh : colors.surface;

    final content = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: radius,
        border: Border.all(color: colors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: content,
      ),
    );
  }
}
