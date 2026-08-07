import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/auth_credentials.dart';
import '../../domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  bool _isAuthenticated = false;

  @override
  Future<bool> isAuthenticated() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return _isAuthenticated;
  }

  @override
  Future<void> login(AuthCredentials credentials) async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    _isAuthenticated = true;
  }

  @override
  Future<void> signUp(AuthCredentials credentials) async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    _isAuthenticated = true;
  }

  @override
  Future<void> logout() async {
    _isAuthenticated = false;
  }
}
