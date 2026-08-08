import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';

final profileControllerProvider = Provider<ProfileController>((ref) {
  return ProfileController(ref);
});

final appVersionProvider = FutureProvider<String>((ref) async {
  return ref.read(profileControllerProvider).getAppVersion();
});

/// Placeholder for future notifications API integration.
final hasUnreadNotificationsProvider = Provider<bool>((ref) => false);

class ProfileController {
  ProfileController(this._ref);

  final Ref _ref;

  Future<String> getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  Future<void> logout() async {
    await _ref.read(authControllerProvider.notifier).logout();
  }
}
