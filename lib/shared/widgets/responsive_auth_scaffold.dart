import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_color_extension.dart';
import '../../core/utils/responsive.dart';
import 'app_logo.dart';
import 'auth_gap.dart';

class ResponsiveAuthScaffold extends StatelessWidget {
  const ResponsiveAuthScaffold({
    super.key,
    required this.child,
    this.showLogo = true,
  });

  final Widget child;
  final bool showLogo;

  @override
  Widget build(BuildContext context) {
    final isWide = Responsive.isTablet(context);
    final horizontalPadding = Responsive.authHorizontalPadding();
    final topSpacing = Responsive.topSpacingBeforeLogo(context);
    final bottomSpacing = Responsive.bottomCtaPadding(context);

    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: bottomSpacing +
                    MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Responsive.authCardMaxWidth(context),
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: isWide
                          ? const EdgeInsets.symmetric(
                              vertical: AppConstants.cardBorderRadius,
                            )
                          : EdgeInsets.zero,
                      decoration: isWide
                          ? BoxDecoration(
                              color: colors.background,
                              borderRadius: BorderRadius.circular(
                                AppConstants.cardBorderRadius,
                              ),
                              border: Border.all(color: colors.border),
                              boxShadow: [
                                BoxShadow(
                                  color: colors.shadow,
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            )
                          : null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: topSpacing),
                          if (showLogo) ...[
                            const Center(child: AppLogo()),
                            const AuthGap.logoToTitle(),
                          ],
                          child,
                          SizedBox(height: bottomSpacing),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
