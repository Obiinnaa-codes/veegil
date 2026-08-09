import 'package:flutter/material.dart';

@immutable
class AppShapeExtension extends ThemeExtension<AppShapeExtension> {
  const AppShapeExtension({
    required this.cardRadius,
    required this.buttonRadius,
    required this.inputRadius,
    required this.chipRadius,
    required this.dialogRadius,
    required this.navIndicatorRadius,
  });

  final double cardRadius;
  final double buttonRadius;
  final double inputRadius;
  final double chipRadius;
  final double dialogRadius;
  final double navIndicatorRadius;

  static const expressive = AppShapeExtension(
    cardRadius: 24,
    buttonRadius: 20,
    inputRadius: 20,
    chipRadius: 16,
    dialogRadius: 28,
    navIndicatorRadius: 16,
  );

  BorderRadius get cardBorderRadius => BorderRadius.circular(cardRadius);
  BorderRadius get buttonBorderRadius => BorderRadius.circular(buttonRadius);
  BorderRadius get inputBorderRadius => BorderRadius.circular(inputRadius);
  BorderRadius get chipBorderRadius => BorderRadius.circular(chipRadius);
  BorderRadius get dialogBorderRadius => BorderRadius.circular(dialogRadius);

  @override
  AppShapeExtension copyWith({
    double? cardRadius,
    double? buttonRadius,
    double? inputRadius,
    double? chipRadius,
    double? dialogRadius,
    double? navIndicatorRadius,
  }) {
    return AppShapeExtension(
      cardRadius: cardRadius ?? this.cardRadius,
      buttonRadius: buttonRadius ?? this.buttonRadius,
      inputRadius: inputRadius ?? this.inputRadius,
      chipRadius: chipRadius ?? this.chipRadius,
      dialogRadius: dialogRadius ?? this.dialogRadius,
      navIndicatorRadius: navIndicatorRadius ?? this.navIndicatorRadius,
    );
  }

  @override
  AppShapeExtension lerp(ThemeExtension<AppShapeExtension>? other, double t) {
    if (other is! AppShapeExtension) return this;

    return AppShapeExtension(
      cardRadius: lerpDouble(cardRadius, other.cardRadius, t)!,
      buttonRadius: lerpDouble(buttonRadius, other.buttonRadius, t)!,
      inputRadius: lerpDouble(inputRadius, other.inputRadius, t)!,
      chipRadius: lerpDouble(chipRadius, other.chipRadius, t)!,
      dialogRadius: lerpDouble(dialogRadius, other.dialogRadius, t)!,
      navIndicatorRadius:
          lerpDouble(navIndicatorRadius, other.navIndicatorRadius, t)!,
    );
  }
}

double? lerpDouble(double a, double b, double t) => a + (b - a) * t;

extension AppShapeExtensionContext on BuildContext {
  AppShapeExtension get appShapes =>
      Theme.of(this).extension<AppShapeExtension>()!;
}
