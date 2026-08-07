import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_paths.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/auth_gap.dart';
import '../../../../shared/widgets/auth_header.dart';
import '../../../../shared/widgets/auth_text_link.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../../../../shared/widgets/responsive_auth_scaffold.dart';
import '../controllers/login_controller.dart';
import '../widgets/auth_footer_link.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final success = await ref.read(loginControllerProvider.notifier).submit();
    if (success && mounted) {
      context.go(RoutePaths.home);
    }
  }

  void _showForgotPasswordMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password recovery is coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginControllerProvider, (previous, next) {
      final error = next.submission.asError;
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.error.toString())),
        );
      }
    });

    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);

    return ResponsiveAuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthHeader(title: 'Welcome Back'),
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
            hint: 'Enter your password',
            value: state.password,
            errorText: state.passwordError,
            obscureText: true,
            showVisibilityToggle: true,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            focusNode: _passwordFocusNode,
            onChanged: controller.onPasswordChanged,
            onSubmitted: (_) => _handleLogin(),
          ),
          const AuthGap.fieldToSupporting(),
          AuthTextLink(
            label: 'Forgot Password?',
            alignment: Alignment.centerRight,
            onTap: _showForgotPasswordMessage,
          ),
          const AuthGap.fieldToPrimaryButton(),
          LoadingButton(
            label: 'Log In',
            loadingLabel: 'Signing In...',
            isLoading: state.isLoading,
            isEnabled: state.isFormValid,
            onPressed: _handleLogin,
          ),
          const AuthGap.primaryButtonToBottomCta(),
          AuthFooterLink(
            prompt: "Don't have an account?",
            actionLabel: 'Sign Up',
            onTap: () => context.push(RoutePaths.signUp),
          ),
        ],
      ),
    );
  }
}
