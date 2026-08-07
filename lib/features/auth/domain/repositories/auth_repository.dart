import '../entities/auth_credentials.dart';

abstract interface class AuthRepository {
  Future<bool> isAuthenticated();
  Future<void> login(AuthCredentials credentials);
  Future<void> signUp(AuthCredentials credentials);
  Future<void> logout();
}
