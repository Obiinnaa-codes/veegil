import 'package:flutter/material.dart';

@immutable
class AppMotionExtension extends ThemeExtension<AppMotionExtension> {
  const AppMotionExtension({
    required this.shortDuration,
    required this.mediumDuration,
    required this.emphasizedCurve,
    required this.standardCurve,
  });

  final Duration shortDuration;
  final Duration mediumDuration;
  final Curve emphasizedCurve;
  final Curve standardCurve;

  static const expressive = AppMotionExtension(
    shortDuration: Duration(milliseconds: 200),
    mediumDuration: Duration(milliseconds: 350),
    emphasizedCurve: Curves.easeOutCubic,
    standardCurve: Curves.easeInOut,
  );

  @override
  AppMotionExtension copyWith({
    Duration? shortDuration,
    Duration? mediumDuration,
    Curve? emphasizedCurve,
    Curve? standardCurve,
  }) {
    return AppMotionExtension(
      shortDuration: shortDuration ?? this.shortDuration,
      mediumDuration: mediumDuration ?? this.mediumDuration,
      emphasizedCurve: emphasizedCurve ?? this.emphasizedCurve,
      standardCurve: standardCurve ?? this.standardCurve,
    );
  }

  @override
  AppMotionExtension lerp(ThemeExtension<AppMotionExtension>? other, double t) {
    if (other is! AppMotionExtension) return this;
    return other;
  }
}

extension AppMotionExtensionContext on BuildContext {
  AppMotionExtension get appMotion =>
      Theme.of(this).extension<AppMotionExtension>()!;
}
