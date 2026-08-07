import '../entities/auth_credentials.dart';
import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<User> login(AuthCredentials credentials);
  Future<User> signup(AuthCredentials credentials);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<bool> hasToken();
}
