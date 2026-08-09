import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/validators.dart';
import '../controllers/login_controller.dart';
import '../controllers/sign_up_controller.dart';

abstract final class AuthFormMessages {
  static String? loginBlockedMessage(LoginState state) {
    if (state.isFormValid) return null;

    if (Validators.phone(state.phoneNumber) != null) {
      return 'Enter a valid phone number to continue';
    }
    if (Validators.password(state.password) != null) {
      return 'Enter your password to continue';
    }

    return null;
  }

  static String? signUpBlockedMessage(SignUpState state) {
    if (state.isFormValid) return null;

    if (Validators.phone(state.phoneNumber) != null) {
      return 'Enter a valid phone number to continue';
    }
    if (Validators.password(
          state.password,
          maxLength: AppConstants.maxPasswordLength,
        ) !=
        null) {
      return 'Password must be 8–128 characters';
    }
    if (Validators.confirmPassword(state.confirmPassword, state.password) !=
        null) {
      return 'Confirm your password to continue';
    }

    return null;
  }

  static void focusFirstInvalidLoginField({
    required LoginState state,
    required FocusNode phoneFocusNode,
    required FocusNode passwordFocusNode,
  }) {
    if (Validators.phone(state.phoneNumber) != null) {
      phoneFocusNode.requestFocus();
      return;
    }
    if (Validators.password(state.password) != null) {
      passwordFocusNode.requestFocus();
    }
  }

  static void focusFirstInvalidSignUpField({
    required SignUpState state,
    required FocusNode phoneFocusNode,
    required FocusNode passwordFocusNode,
    required FocusNode confirmPasswordFocusNode,
  }) {
    if (Validators.phone(state.phoneNumber) != null) {
      phoneFocusNode.requestFocus();
      return;
    }
    if (Validators.password(
          state.password,
          maxLength: AppConstants.maxPasswordLength,
        ) !=
        null) {
      passwordFocusNode.requestFocus();
      return;
    }
    if (Validators.confirmPassword(state.confirmPassword, state.password) !=
        null) {
      confirmPasswordFocusNode.requestFocus();
    }
  }
}
