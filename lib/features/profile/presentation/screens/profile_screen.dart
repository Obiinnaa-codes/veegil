import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/route_paths.dart';
import '../../../../core/theme/account_spacing.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/analytics_card.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../dashboard/presentation/controllers/dashboard_controller.dart';
import '../controllers/profile_controller.dart';
import '../widgets/account_header.dart';
import '../widgets/account_information_card.dart';
import '../widgets/app_version_card.dart';
import '../widgets/hero_account_card.dart';
import '../widgets/logout_card.dart';
import '../widgets/logout_confirmation_dialog.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _onRefresh(WidgetRef ref) async {
    await ref.read(dashboardControllerProvider.notifier).refresh();
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showLogoutConfirmationDialog(context);
    if (!confirmed) return;

    await ref.read(profileControllerProvider).logout();
    if (context.mounted) {
      context.go(RoutePaths.login);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _onRefresh(ref),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AccountSpacing.pagePadding,
                  vertical: AppSpacing.md,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Responsive.dashboardMaxContentWidth(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AccountHeader(),
                        const SizedBox(height: AccountSpacing.sectionGap),
                        const _HeroSection(),
                        const SizedBox(height: AccountSpacing.sectionGap),
                        const _AccountInformationSection(),
                        const SizedBox(height: AccountSpacing.sectionGap),
                        AnalyticsCard(
                          onTap: () => context.push(RoutePaths.analytics),
                        ),
                        const SizedBox(height: AccountSpacing.sectionGap),
                        const _AppVersionSection(),
                        const SizedBox(height: AccountSpacing.sectionGap),
                        LogoutCard(
                          onTap: () => _handleLogout(context, ref),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends ConsumerWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(
      authControllerProvider.select((s) => s.valueOrNull?.phoneNumber),
    );
    final memberSince = ref.watch(
      dashboardControllerProvider.select((s) => s.valueOrNull?.created),
    );

    if (phoneNumber == null) return const SizedBox.shrink();

    return HeroAccountCard(
      phoneNumber: phoneNumber,
      memberSince: memberSince,
    );
  }
}

class _AccountInformationSection extends ConsumerWidget {
  const _AccountInformationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(
      authControllerProvider.select((s) => s.valueOrNull?.phoneNumber),
    );
    final memberSince = ref.watch(
      dashboardControllerProvider.select((s) => s.valueOrNull?.created),
    );

    if (phoneNumber == null) return const SizedBox.shrink();

    return AccountInformationCard(
      phoneNumber: phoneNumber,
      memberSince: memberSince,
    );
  }
}

class _AppVersionSection extends ConsumerWidget {
  const _AppVersionSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appVersion = ref.watch(appVersionProvider);

    return AppVersionCard(
      version: appVersion.when(
        data: (version) => version,
        loading: () => '—',
        error: (_, _) => '—',
      ),
    );
  }
}
