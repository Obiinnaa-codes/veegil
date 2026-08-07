import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/validators.dart';
import '../../domain/entities/auth_credentials.dart';
import 'auth_repository_provider.dart';

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
    final passwordError = Validators.password(state.password);
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

    state = state.copyWith(submission: const AsyncLoading());

    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.signUp(
        AuthCredentials(
          phoneNumber: state.phoneNumber.trim(),
          password: state.password,
        ),
      );
      state = state.copyWith(submission: const AsyncData(null));
      return true;
    } catch (error, stackTrace) {
      state = state.copyWith(
        submission: AsyncError(error, stackTrace),
      );
      return false;
    }
  }
}
