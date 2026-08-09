import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/auth_spacing.dart';
import '../theme/dashboard_spacing.dart';

abstract final class Responsive {
  static const double tabletBreakpoint = 600;
  static const double shortScreenHeight = 700;

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= tabletBreakpoint;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.landscape;
  }

  static double authHorizontalPadding() => AuthSpacing.pageHorizontal;

  static double topSpacingBeforeLogo(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    if (height >= shortScreenHeight) {
      return AuthSpacing.topBeforeLogoMax;
    }

    final ratio = (height / shortScreenHeight).clamp(0.5, 1.0);
    return (AuthSpacing.topBeforeLogoMin * ratio).clamp(48.0, AuthSpacing.topBeforeLogoMax);
  }

  static double topSpacingBeforeIllustration(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    if (height >= shortScreenHeight) {
      return AuthSpacing.topBeforeIllustrationMax;
    }

    final ratio = (height / shortScreenHeight).clamp(0.5, 1.0);
    return (AuthSpacing.topBeforeIllustrationMin * ratio)
        .clamp(AuthSpacing.topBeforeIllustrationMin, AuthSpacing.topBeforeIllustrationMax);
  }

  static double authIllustrationHeight(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    if (height < shortScreenHeight) return 140;
    if (height < 800) return 180;
    return 220;
  }

  static double bottomCtaPadding(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    if (height >= shortScreenHeight) {
      return AuthSpacing.bottomCtaToSafeAreaMax;
    }

    final ratio = (height / shortScreenHeight).clamp(0.8, 1.0);
    return (AuthSpacing.bottomCtaToSafeAreaMin * ratio)
        .clamp(AuthSpacing.bottomCtaToSafeAreaMin, AuthSpacing.bottomCtaToSafeAreaMax);
  }

  static EdgeInsets authPagePadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: authHorizontalPadding(),
    );
  }

  static double authCardMaxWidth(BuildContext context) {
    return AppConstants.authCardMaxWidth;
  }

  static double dashboardMaxContentWidth(BuildContext context) {
    return AppConstants.dashboardContentMaxWidth;
  }

  static double dashboardHorizontalPadding() => DashboardSpacing.pageHorizontal;
}
