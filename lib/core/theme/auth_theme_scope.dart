import 'package:flutter/material.dart';

import '../constants/route_paths.dart';
import 'app_theme.dart';

/// Forces the light theme for unauthenticated entry screens.
class AuthThemeScope extends StatelessWidget {
  const AuthThemeScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: child,
    );
  }
}

bool isAuthRoute(String location) {
  return location == RoutePaths.splash ||
      location == RoutePaths.login ||
      location == RoutePaths.signUp;
}
