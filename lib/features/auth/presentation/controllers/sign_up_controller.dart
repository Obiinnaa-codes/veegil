import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/validators.dart';
import '../controllers/auth_controller.dart';

class SignUpState {
  const SignUpState({
    this.phoneNumber = '',
    this.password = '',
    this.confirmPassword = '',
    this.phoneError,
    this.passwordError,
    this.confirmPasswordError,
    this.submission = const AsyncData(null),
  });

  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String? phoneError;
  final String? passwordError;
  final String? confirmPasswordError;
  final AsyncValue<void> submission;

  bool get isLoading => submission.isLoading;

  bool get isFormValid =>
      Validators.phone(phoneNumber) == null &&
      Validators.password(
            password,
            maxLength: AppConstants.maxPasswordLength,
          ) ==
          null &&
      Validators.confirmPassword(confirmPassword, password) == null;

  SignUpState copyWith({
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    String? phoneError,
    String? passwordError,
    String? confirmPasswordError,
    bool clearPhoneError = false,
    bool clearPasswordError = false,
    bool clearConfirmPasswordError = false,
    AsyncValue<void>? submission,
  }) {
    return SignUpState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phoneError: clearPhoneError ? null : (phoneError ?? this.phoneError),
      passwordError:
          clearPasswordError ? null : (passwordError ?? this.passwordError),
      confirmPasswordError: clearConfirmPasswordError
          ? null
          : (confirmPasswordError ?? this.confirmPasswordError),
      submission: submission ?? this.submission,
    );
  }
}

final signUpControllerProvider =
    NotifierProvider<SignUpController, SignUpState>(SignUpController.new);

class SignUpController extends Notifier<SignUpState> {
  @override
  SignUpState build() => const SignUpState();

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

  void onConfirmPasswordChanged(String value) {
    state = state.copyWith(
      confirmPassword: value,
      clearConfirmPasswordError: true,
    );
  }

  bool _validate() {
    final phoneError = Validators.phone(state.phoneNumber);
    final passwordError = Validators.password(
      state.password,
      maxLength: AppConstants.maxPasswordLength,
    );
    final confirmPasswordError = Validators.confirmPassword(
      state.confirmPassword,
      state.password,
    );

    state = state.copyWith(
      phoneError: phoneError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      clearPhoneError: phoneError == null,
      clearPasswordError: passwordError == null,
      clearConfirmPasswordError: confirmPasswordError == null,
    );

    return phoneError == null &&
        passwordError == null &&
        confirmPasswordError == null;
  }

  Future<bool> submit() async {
    if (!_validate()) return false;
    if (state.isLoading) return false;

    state = state.copyWith(submission: const AsyncLoading());

    try {
      await ref.read(authControllerProvider.notifier).signup(
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
