import 'package:flutter/material.dart';

import '../../core/theme/auth_spacing.dart';
import '../../core/utils/responsive.dart';

class AuthGap extends StatelessWidget {
  const AuthGap.logoToTitle({super.key}) : height = AuthSpacing.logoToTitle;
  const AuthGap.illustrationToTitle({super.key})
      : height = AuthSpacing.illustrationToTitle;
  const AuthGap.titleToContent({super.key})
      : height = AuthSpacing.titleToContent;
  const AuthGap.labelToField({super.key}) : height = AuthSpacing.labelToField;
  const AuthGap.fieldToNextLabel({super.key})
      : height = AuthSpacing.supportingToNextLabel;
  const AuthGap.fieldToSupporting({super.key})
      : height = AuthSpacing.fieldToSupporting;
  const AuthGap.fieldToPrimaryButton({super.key})
      : height = AuthSpacing.fieldToPrimaryButton;
  const AuthGap.primaryButtonToBottomCta({super.key})
      : height = AuthSpacing.primaryButtonToBottomCta;

  AuthGap.bottomCtaToSafeArea({super.key, required BuildContext context})
      : height = Responsive.bottomCtaPadding(context);

  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}
