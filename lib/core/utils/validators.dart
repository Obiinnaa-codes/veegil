import '../constants/app_constants.dart';
import 'currency_formatter.dart';

abstract final class Validators {
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final digits = value.trim();
    if (!RegExp(r'^\d+$').hasMatch(digits)) {
      return 'Phone number must contain only digits';
    }

    if (digits.length < AppConstants.minPhoneLength ||
        digits.length > AppConstants.maxPhoneLength) {
      return 'Phone number must be ${AppConstants.minPhoneLength}-${AppConstants.maxPhoneLength} digits';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? amount(int? value) {
    if (value == null) {
      return 'Amount is required';
    }

    if (value < 0) {
      return 'Amount cannot be negative';
    }

    if (value == 0) {
      return 'Amount must be greater than zero';
    }

    return null;
  }

  static String? insufficientBalance(int amount, double availableBalance) {
    if (amount > availableBalance) {
      return 'Insufficient balance. Available: ${CurrencyFormatter.format(availableBalance)}';
    }

    return null;
  }

  static String? notSelfPhone(String phone, String? currentPhone) {
    if (currentPhone == null) return null;

    if (phone.trim() == currentPhone.trim()) {
      return 'You cannot transfer to your own account';
    }

    return null;
  }
}
