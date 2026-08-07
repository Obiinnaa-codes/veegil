import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/route_paths.dart';
import '../../features/auth/presentation/providers/auth_repository_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: RoutePaths.login,
    debugLogDiagnostics: false,
    redirect: (context, state) async {
      final isAuthenticated = await repository.isAuthenticated();
      final location = state.matchedLocation;

      if (isAuthenticated &&
          (location == RoutePaths.login || location == RoutePaths.signUp)) {
        return RoutePaths.home;
      }

      if (!isAuthenticated && location == RoutePaths.home) {
        return RoutePaths.login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.login,
        pageBuilder: (context, state) => _slidePage(
          state: state,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.signUp,
        pageBuilder: (context, state) => _slidePage(
          state: state,
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.home,
        pageBuilder: (context, state) => _fadePage(
          state: state,
          child: const HomeScreen(),
        ),
      ),
    ],
  );
});

CustomTransitionPage<void> _fadePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

CustomTransitionPage<void> _slidePage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
      );

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
