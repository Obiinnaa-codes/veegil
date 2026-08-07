import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/validators.dart';
import '../controllers/auth_controller.dart';

class LoginState {
  const LoginState({
    this.phoneNumber = '',
    this.password = '',
    this.phoneError,
    this.passwordError,
    this.submission = const AsyncData(null),
  });

  final String phoneNumber;
  final String password;
  final String? phoneError;
  final String? passwordError;
  final AsyncValue<void> submission;

  bool get isLoading => submission.isLoading;

  bool get isFormValid =>
      Validators.phone(phoneNumber) == null &&
      Validators.password(password) == null;

  LoginState copyWith({
    String? phoneNumber,
    String? password,
    String? phoneError,
    String? passwordError,
    bool clearPhoneError = false,
    bool clearPasswordError = false,
    AsyncValue<void>? submission,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      phoneError: clearPhoneError ? null : (phoneError ?? this.phoneError),
      passwordError:
          clearPasswordError ? null : (passwordError ?? this.passwordError),
      submission: submission ?? this.submission,
    );
  }
}

final loginControllerProvider =
    NotifierProvider<LoginController, LoginState>(LoginController.new);

class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState();

  void onPhoneChanged(String value) {
    state = state.copyWith(
      phoneNumber: value,
      clearPhoneError: true,
    );
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(
      password: value,
      clearPasswordError: true,
    );
  }

  bool _validate() {
    final phoneError = Validators.phone(state.phoneNumber);
    final passwordError = Validators.password(state.password);

    state = state.copyWith(
      phoneError: phoneError,
      passwordError: passwordError,
      clearPhoneError: phoneError == null,
      clearPasswordError: passwordError == null,
    );

    return phoneError == null && passwordError == null;
  }

  Future<bool> submit() async {
    if (!_validate()) return false;
    if (state.isLoading) return false;

    state = state.copyWith(submission: const AsyncLoading());

    try {
      await ref.read(authControllerProvider.notifier).login(
            phoneNumber: state.phoneNumber.trim(),
            password: state.password,
          );

      final authState = ref.read(authControllerProvider);
      if (authState.hasError) {
        throw authState.error!;
      }

      state = state.copyWith(submission: const AsyncData(null));
      return true;
    } catch (error, stackTrace) {
      state = state.copyWith(
        submission: AsyncError(_mapError(error), stackTrace),
      );
      return false;
    }
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
