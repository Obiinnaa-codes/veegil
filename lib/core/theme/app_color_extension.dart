import 'package:flutter/material.dart';

import 'app_colors.dart';

@immutable
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  const AppColorExtension({
    required this.background,
    required this.surface,
    required this.surfaceContainerHigh,
    required this.text,
    required this.subtitle,
    required this.border,
    required this.outlineVariant,
    required this.shadow,
    required this.inputShadow,
    required this.snackBarBackground,
    required this.snackBarForeground,
    required this.primaryContainer,
    required this.onPrimaryContainer,
  });

  final Color background;
  final Color surface;
  final Color surfaceContainerHigh;
  final Color text;
  final Color subtitle;
  final Color border;
  final Color outlineVariant;
  final Color shadow;
  final Color inputShadow;
  final Color snackBarBackground;
  final Color snackBarForeground;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  static const light = AppColorExtension(
    background: AppColors.background,
    surface: AppColors.surface,
    surfaceContainerHigh: Color(0xFFF0F4F2),
    text: AppColors.text,
    subtitle: AppColors.subtitle,
    border: AppColors.border,
    outlineVariant: Color(0xFFD1D5DB),
    shadow: AppColors.shadow,
    inputShadow: AppColors.inputShadow,
    snackBarBackground: AppColors.text,
    snackBarForeground: AppColors.surface,
    primaryContainer: Color(0xFFD4EDE4),
    onPrimaryContainer: AppColors.primary,
  );

  static const dark = AppColorExtension(
    background: Color(0xFF0B1411),
    surface: Color(0xFF152620),
    surfaceContainerHigh: Color(0xFF1C2F28),
    text: Color(0xFFF0F4F2),
    subtitle: Color(0xFF9CA3AF),
    border: Color(0xFF2A3D35),
    outlineVariant: Color(0xFF3D5249),
    shadow: Color(0x40000000),
    inputShadow: Color(0x20000000),
    snackBarBackground: Color(0xFF1E2E28),
    snackBarForeground: Color(0xFFF0F4F2),
    primaryContainer: Color(0xFF1A4D3C),
    onPrimaryContainer: Color(0xFFB8E8D8),
  );

  @override
  AppColorExtension copyWith({
    Color? background,
    Color? surface,
    Color? surfaceContainerHigh,
    Color? text,
    Color? subtitle,
    Color? border,
    Color? outlineVariant,
    Color? shadow,
    Color? inputShadow,
    Color? snackBarBackground,
    Color? snackBarForeground,
    Color? primaryContainer,
    Color? onPrimaryContainer,
  }) {
    return AppColorExtension(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceContainerHigh:
          surfaceContainerHigh ?? this.surfaceContainerHigh,
      text: text ?? this.text,
      subtitle: subtitle ?? this.subtitle,
      border: border ?? this.border,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      shadow: shadow ?? this.shadow,
      inputShadow: inputShadow ?? this.inputShadow,
      snackBarBackground: snackBarBackground ?? this.snackBarBackground,
      snackBarForeground: snackBarForeground ?? this.snackBarForeground,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
    );
  }

  @override
  AppColorExtension lerp(ThemeExtension<AppColorExtension>? other, double t) {
    if (other is! AppColorExtension) return this;

    return AppColorExtension(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceContainerHigh:
          Color.lerp(surfaceContainerHigh, other.surfaceContainerHigh, t)!,
      text: Color.lerp(text, other.text, t)!,
      subtitle: Color.lerp(subtitle, other.subtitle, t)!,
      border: Color.lerp(border, other.border, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      inputShadow: Color.lerp(inputShadow, other.inputShadow, t)!,
      snackBarBackground:
          Color.lerp(snackBarBackground, other.snackBarBackground, t)!,
      snackBarForeground:
          Color.lerp(snackBarForeground, other.snackBarForeground, t)!,
      primaryContainer:
          Color.lerp(primaryContainer, other.primaryContainer, t)!,
      onPrimaryContainer:
          Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t)!,
    );
  }
}

extension AppColorExtensionContext on BuildContext {
  AppColorExtension get appColors =>
      Theme.of(this).extension<AppColorExtension>()!;
}
