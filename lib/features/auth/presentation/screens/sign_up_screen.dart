import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/route_paths.dart';
import '../../../../core/utils/phone_formatter.dart';
import '../../../../core/utils/phone_input_formatter.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/auth_field_hint.dart';
import '../../../../shared/widgets/auth_gap.dart';
import '../../../../shared/widgets/auth_header.dart';
import '../../../../shared/widgets/auth_submission_banner.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../../../../shared/widgets/responsive_auth_scaffold.dart';
import '../controllers/sign_up_controller.dart';
import '../utils/auth_form_messages.dart';
import '../utils/auth_haptic_feedback.dart';
import '../utils/auth_scroll_helper.dart';
import '../widgets/auth_footer_link.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    for (final node in [
      _phoneFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode,
    ]) {
      AuthScrollHelper.attachScrollOnFocus(
        node,
        () => AuthScrollHelper.scrollToFocusedField(node),
      );
    }
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final success =
        await ref.read(signUpControllerProvider.notifier).submit();
    if (success && mounted) {
      AuthHapticFeedback.success();
      context.go(RoutePaths.dashboard);
    }
  }

  void _focusFirstInvalidField(SignUpState state) {
    AuthFormMessages.focusFirstInvalidSignUpField(
      state: state,
      phoneFocusNode: _phoneFocusNode,
      passwordFocusNode: _passwordFocusNode,
      confirmPasswordFocusNode: _confirmPasswordFocusNode,
    );
    final focusNode = Validators.phone(state.phoneNumber) != null
        ? _phoneFocusNode
        : Validators.password(
                  state.password,
                  maxLength: AppConstants.maxPasswordLength,
                ) !=
                null
            ? _passwordFocusNode
            : _confirmPasswordFocusNode;
    AuthScrollHelper.scrollToFocusedField(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpControllerProvider);
    final controller = ref.read(signUpControllerProvider.notifier);
    final submissionError = state.submission.asError?.error.toString();
    final isPasswordValid = state.password.isNotEmpty &&
        Validators.password(
              state.password,
              maxLength: AppConstants.maxPasswordLength,
            ) ==
            null;
    return ResponsiveAuthScaffold(
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(
              title: 'Create your account',
              subtitle: 'Get started with simple, secure banking.',
            ),
            const AuthGap.titleToContent(),
            AppTextField(
              label: 'Phone Number',
              hint: 'Enter your phone number',
              value: state.phoneNumber,
              errorText: state.phoneError,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.telephoneNumber],
              inputFormatters: [PhoneInputFormatter()],
              displayValue: PhoneFormatter.formatDisplay,
              focusNode: _phoneFocusNode,
              onChanged: controller.onPhoneChanged,
              onSubmitted: (_) => _passwordFocusNode.requestFocus(),
            ),
            const AuthGap.fieldToNextLabel(),
            AppTextField(
              label: 'Password',
              hint: 'Create a password',
              value: state.password,
              errorText: state.passwordError,
              obscureText: true,
              showVisibilityToggle: true,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              inputFormatters: [
                LengthLimitingTextInputFormatter(AppConstants.maxPasswordLength),
              ],
              focusNode: _passwordFocusNode,
              onChanged: controller.onPasswordChanged,
              onSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
              guidance: AuthFieldHint(
                text: 'Password must be 8–128 characters',
                isValid: isPasswordValid,
              ),
            ),
            const AuthGap.fieldToNextLabel(),
            AppTextField(
              label: 'Confirm Password',
              hint: 'Re-enter your password',
              value: state.confirmPassword,
              errorText: state.confirmPasswordError,
              obscureText: true,
              showVisibilityToggle: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              focusNode: _confirmPasswordFocusNode,
              onChanged: controller.onConfirmPasswordChanged,
              onSubmitted: (_) => _handleSignUp(),
            ),
            if (submissionError != null) ...[
              const AuthGap.fieldToSupporting(),
              AuthSubmissionBanner(message: submissionError),
            ],
            const AuthGap.fieldToPrimaryButton(),
            LoadingButton(
              label: 'Sign Up',
              loadingLabel: 'Creating account...',
              isLoading: state.isLoading,
              isEnabled: state.isFormValid,
              onInvalidTap: () => _focusFirstInvalidField(state),
              onPressed: _handleSignUp,
            ),
            const AuthGap.primaryButtonToBottomCta(),
            AuthFooterLink(
              prompt: 'Already have an account?',
              actionLabel: 'Log In',
              onTap: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
