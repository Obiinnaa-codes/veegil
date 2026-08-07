import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/validators.dart';
import '../../domain/entities/auth_credentials.dart';
import 'auth_repository_provider.dart';

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

    state = state.copyWith(submission: const AsyncLoading());

    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.login(
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
