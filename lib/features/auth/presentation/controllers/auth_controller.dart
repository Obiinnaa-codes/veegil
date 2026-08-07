import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/auth_credentials.dart';
import '../../domain/entities/user.dart';
import '../providers/core_providers.dart';

final authControllerProvider =
    AsyncNotifierProvider<AuthController, User?>(AuthController.new);

class AuthController extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    final repository = ref.read(authRepositoryProvider);
    final hasToken = await repository.hasToken();
    if (!hasToken) return null;
    return repository.getCurrentUser();
  }

  Future<void> login({
    required String phoneNumber,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return repository.login(
        AuthCredentials(phoneNumber: phoneNumber, password: password),
      );
    });
  }

  Future<void> signup({
    required String phoneNumber,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return repository.signup(
        AuthCredentials(phoneNumber: phoneNumber, password: password),
      );
    });
  }

  Future<void> logout() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.logout();
    state = const AsyncData(null);
  }
}
