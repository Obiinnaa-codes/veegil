import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/account.dart';
import '../providers/core_providers.dart';

final dashboardRefreshErrorProvider = StateProvider<String?>((ref) => null);

final dashboardControllerProvider =
    AsyncNotifierProvider<DashboardController, Account>(DashboardController.new);

class DashboardController extends AsyncNotifier<Account> {
  @override
  Future<Account> build() async {
    final repository = ref.read(dashboardRepositoryProvider);
    try {
      return await repository.getCurrentUser();
    } on Object catch (error) {
      if (_isUnauthorized(error)) {
        await ref.read(authControllerProvider.notifier).logout();
      }
      rethrow;
    }
  }

  Future<void> refresh() async {
    final previous = state.valueOrNull;
    ref.read(dashboardRefreshErrorProvider.notifier).state = null;

    try {
      final repository = ref.read(dashboardRepositoryProvider);
      final account = await repository.refresh();
      state = AsyncData(account);
    } catch (error, stackTrace) {
      if (_isUnauthorized(error)) {
        await ref.read(authControllerProvider.notifier).logout();
        return;
      }

      if (previous != null) {
        state = AsyncData(previous);
        ref.read(dashboardRefreshErrorProvider.notifier).state =
            _mapError(error);
      } else {
        state = AsyncError(error, stackTrace);
      }
    }
  }

  bool _isUnauthorized(Object error) {
    if (error is DioException) {
      return error.response?.statusCode == 401 ||
          error.apiException.statusCode == 401;
    }
    if (error is ApiException) {
      return error.statusCode == 401;
    }
    return false;
  }

  String _mapError(Object error) {
    if (error is DioException) {
      return error.apiException.userMessage;
    }
    if (error is ApiException) {
      return error.userMessage;
    }
    return 'Something went wrong. Please try again.';
  }
}
