import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_paths.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/auth_gap.dart';
import '../../../../shared/widgets/auth_header.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../../../../shared/widgets/responsive_auth_scaffold.dart';
import '../providers/sign_up_controller.dart';
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
      context.go(RoutePaths.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpControllerProvider);
    final controller = ref.read(signUpControllerProvider.notifier);

    return ResponsiveAuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthHeader(title: 'Create Account'),
          const AuthGap.titleToContent(),
          AppTextField(
            label: 'Phone Number',
            hint: 'Enter your phone number',
            value: state.phoneNumber,
            errorText: state.phoneError,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.telephoneNumber],
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
            focusNode: _passwordFocusNode,
            onChanged: controller.onPasswordChanged,
            onSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
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
          const AuthGap.fieldToPrimaryButton(),
          LoadingButton(
            label: 'Create Account',
            isLoading: state.isLoading,
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
    );
  }
}
