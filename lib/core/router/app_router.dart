import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/route_paths.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/deposit/presentation/screens/deposit_screen.dart';
import '../../features/dashboard/presentation/screens/placeholders/transfer_placeholder_screen.dart';
import '../../features/dashboard/presentation/screens/placeholders/withdraw_placeholder_screen.dart';
import '../../features/dashboard/presentation/screens/tab_placeholder_screens.dart';
import '../../features/transactions/presentation/screens/transactions_screen.dart';
import '../../features/dashboard/presentation/widgets/dashboard_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

bool _isAuthenticatedRoute(String location) {
  return location == RoutePaths.dashboard ||
      location == RoutePaths.transactions ||
      location == RoutePaths.profile ||
      location == RoutePaths.deposit ||
      location == RoutePaths.withdraw ||
      location == RoutePaths.transfer;
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = _RouterRefreshNotifier();

  ref.listen(authControllerProvider, (_, _) {
    refreshNotifier.notify();
  });

  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: false,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final location = state.matchedLocation;
      final isLoading = authState.isLoading;
      final isAuthenticated = authState.valueOrNull != null;

      if (isLoading && location != RoutePaths.splash) {
        return RoutePaths.splash;
      }

      if (!isLoading && isAuthenticated) {
        if (location == RoutePaths.login ||
            location == RoutePaths.signUp ||
            location == RoutePaths.splash) {
          return RoutePaths.dashboard;
        }
      }

      if (!isLoading && !isAuthenticated) {
        if (_isAuthenticatedRoute(location) || location == RoutePaths.splash) {
          return RoutePaths.login;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        pageBuilder: (context, state) => _fadePage(
          state: state,
          child: const SplashScreen(),
        ),
      ),
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
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => DashboardShell(child: child),
        routes: [
          GoRoute(
            path: RoutePaths.dashboard,
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const DashboardScreen(),
            ),
          ),
          GoRoute(
            path: RoutePaths.transactions,
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const TransactionsScreen(),
            ),
          ),
          GoRoute(
            path: RoutePaths.profile,
            pageBuilder: (context, state) => _fadePage(
              state: state,
              child: const ProfilePlaceholderScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RoutePaths.deposit,
        pageBuilder: (context, state) => _slidePage(
          state: state,
          child: const DepositScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RoutePaths.withdraw,
        pageBuilder: (context, state) => _slidePage(
          state: state,
          child: const WithdrawPlaceholderScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: RoutePaths.transfer,
        pageBuilder: (context, state) => _slidePage(
          state: state,
          child: const TransferPlaceholderScreen(),
        ),
      ),
    ],
  );
});

class _RouterRefreshNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}

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
