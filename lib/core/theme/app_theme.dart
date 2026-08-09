import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_constants.dart';
import 'app_color_extension.dart';
import 'app_colors.dart';
import 'app_motion_extension.dart';
import 'app_shape_extension.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light => _buildTheme(
        brightness: Brightness.light,
        colors: AppColorExtension.light,
        overlayStyle: SystemUiOverlayStyle.dark,
      );

  static ThemeData get dark => _buildTheme(
        brightness: Brightness.dark,
        colors: AppColorExtension.dark,
        overlayStyle: SystemUiOverlayStyle.light,
      );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required AppColorExtension colors,
    required SystemUiOverlayStyle overlayStyle,
  }) {
    const shapes = AppShapeExtension.expressive;
    const motion = AppMotionExtension.expressive;

    final textTheme = AppTypography.createTextTheme(
      text: colors.text,
      subtitle: colors.subtitle,
    );
    final typography = AppTypography(textTheme);

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: colors.primaryContainer,
      onPrimaryContainer: colors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.text,
      surface: colors.surface,
      onSurface: colors.text,
      surfaceContainerHigh: colors.surfaceContainerHigh,
      outline: colors.border,
      outlineVariant: colors.outlineVariant,
      error: AppColors.error,
      onError: AppColors.onPrimary,
    );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: shapes.buttonBorderRadius,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: colors.background,
      colorScheme: colorScheme,
      extensions: [colors, shapes, motion],
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.text,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
        systemOverlayStyle: overlayStyle,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.background,
        surfaceTintColor: Colors.transparent,
        indicatorColor: colors.primaryContainer,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(shapes.navIndicatorRadius),
        ),
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return typography.label.copyWith(
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : colors.subtitle,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : colors.subtitle,
          );
        }),
      ),
      cardTheme: CardThemeData(
        color: colors.surfaceContainerHigh,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: shapes.cardBorderRadius,
          side: BorderSide(color: colors.outlineVariant),
        ),
        margin: EdgeInsets.zero,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed) ||
                states.contains(WidgetState.hovered)) {
              return AppColors.primary;
            }
            return colors.text;
          }),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return colors.primaryContainer.withValues(alpha: 0.6);
            }
            if (states.contains(WidgetState.hovered)) {
              return colors.primaryContainer.withValues(alpha: 0.3);
            }
            return null;
          }),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.background,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.inputHorizontalPadding,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: shapes.inputBorderRadius,
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: shapes.inputBorderRadius,
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: shapes.inputBorderRadius,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: shapes.inputBorderRadius,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: shapes.inputBorderRadius,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: typography.body.copyWith(color: colors.text),
        hintStyle: typography.body.copyWith(color: colors.subtitle),
        errorStyle: typography.label.copyWith(color: AppColors.error),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size.fromHeight(AppConstants.buttonHeight),
          shape: buttonShape,
          elevation: 0,
          textStyle: typography.body.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size.fromHeight(AppConstants.buttonHeight),
          shape: buttonShape,
          elevation: 0,
          textStyle: typography.body.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(AppConstants.buttonHeight),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: buttonShape,
          textStyle: typography.body.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: typography.caption.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceContainerHigh,
        selectedColor: AppColors.primary,
        disabledColor: colors.surfaceContainerHigh,
        labelStyle: typography.label,
        secondaryLabelStyle: typography.label.copyWith(
          color: AppColors.onPrimary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: shapes.chipBorderRadius,
          side: BorderSide(color: colors.outlineVariant),
        ),
        showCheckmark: false,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.snackBarBackground,
        contentTextStyle:
            typography.caption.copyWith(color: colors.snackBarForeground),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: shapes.buttonBorderRadius,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: colors.outlineVariant,
        circularTrackColor: colors.outlineVariant,
        linearMinHeight: 4,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: shapes.dialogBorderRadius,
        ),
      ),
    );
  }
}
