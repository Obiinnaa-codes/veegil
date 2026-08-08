import 'package:flutter/material.dart';

import 'app_colors.dart';

@immutable
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  const AppColorExtension({
    required this.background,
    required this.surface,
    required this.text,
    required this.subtitle,
    required this.border,
    required this.shadow,
    required this.inputShadow,
    required this.snackBarBackground,
    required this.snackBarForeground,
  });

  final Color background;
  final Color surface;
  final Color text;
  final Color subtitle;
  final Color border;
  final Color shadow;
  final Color inputShadow;
  final Color snackBarBackground;
  final Color snackBarForeground;

  static const light = AppColorExtension(
    background: AppColors.background,
    surface: AppColors.surface,
    text: AppColors.text,
    subtitle: AppColors.subtitle,
    border: AppColors.border,
    shadow: AppColors.shadow,
    inputShadow: AppColors.inputShadow,
    snackBarBackground: AppColors.text,
    snackBarForeground: AppColors.surface,
  );

  static const dark = AppColorExtension(
    background: Color(0xFF0B1411),
    surface: Color(0xFF152620),
    text: Color(0xFFF0F4F2),
    subtitle: Color(0xFF9CA3AF),
    border: Color(0xFF2A3D35),
    shadow: Color(0x40000000),
    inputShadow: Color(0x20000000),
    snackBarBackground: Color(0xFF1E2E28),
    snackBarForeground: Color(0xFFF0F4F2),
  );

  @override
  AppColorExtension copyWith({
    Color? background,
    Color? surface,
    Color? text,
    Color? subtitle,
    Color? border,
    Color? shadow,
    Color? inputShadow,
    Color? snackBarBackground,
    Color? snackBarForeground,
  }) {
    return AppColorExtension(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      subtitle: subtitle ?? this.subtitle,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
      inputShadow: inputShadow ?? this.inputShadow,
      snackBarBackground: snackBarBackground ?? this.snackBarBackground,
      snackBarForeground: snackBarForeground ?? this.snackBarForeground,
    );
  }

  @override
  AppColorExtension lerp(ThemeExtension<AppColorExtension>? other, double t) {
    if (other is! AppColorExtension) return this;

    return AppColorExtension(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      text: Color.lerp(text, other.text, t)!,
      subtitle: Color.lerp(subtitle, other.subtitle, t)!,
      border: Color.lerp(border, other.border, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      inputShadow: Color.lerp(inputShadow, other.inputShadow, t)!,
      snackBarBackground:
          Color.lerp(snackBarBackground, other.snackBarBackground, t)!,
      snackBarForeground:
          Color.lerp(snackBarForeground, other.snackBarForeground, t)!,
    );
  }
}

extension AppColorExtensionContext on BuildContext {
  AppColorExtension get appColors =>
      Theme.of(this).extension<AppColorExtension>()!;
}
