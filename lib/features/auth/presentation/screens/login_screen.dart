import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_paths.dart';
import '../../../../core/utils/phone_formatter.dart';
import '../../../../core/utils/phone_input_formatter.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/auth_gap.dart';
import '../../../../shared/widgets/auth_header.dart';
import '../../../../shared/widgets/auth_submission_banner.dart';
import '../../../../shared/widgets/loading_button.dart';
import '../../../../shared/widgets/responsive_auth_scaffold.dart';
import '../controllers/login_controller.dart';
import '../utils/auth_form_messages.dart';
import '../utils/auth_haptic_feedback.dart';
import '../utils/auth_scroll_helper.dart';
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
  void initState() {
    super.initState();
    for (final node in [_phoneFocusNode, _passwordFocusNode]) {
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
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final success = await ref.read(loginControllerProvider.notifier).submit();
    if (success && mounted) {
      AuthHapticFeedback.success();
      context.go(RoutePaths.dashboard);
    }
  }

  void _focusFirstInvalidField(LoginState state) {
    AuthFormMessages.focusFirstInvalidLoginField(
      state: state,
      phoneFocusNode: _phoneFocusNode,
      passwordFocusNode: _passwordFocusNode,
    );
    final node = Validators.phone(state.phoneNumber) != null
        ? _phoneFocusNode
        : _passwordFocusNode;
    AuthScrollHelper.scrollToFocusedField(node);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);
    final submissionError = state.submission.asError?.error.toString();

    return ResponsiveAuthScaffold(
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(
              title: 'Welcome back',
              subtitle: 'Sign in to your account',
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
            if (submissionError != null) ...[
              const AuthGap.fieldToSupporting(),
              AuthSubmissionBanner(message: submissionError),
            ],
            const AuthGap.fieldToPrimaryButton(),
            LoadingButton(
              label: 'Sign In',
              loadingLabel: 'Signing in...',
              isLoading: state.isLoading,
              isEnabled: state.isFormValid,
              onInvalidTap: () => _focusFirstInvalidField(state),
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
      ),
    );
  }
}
