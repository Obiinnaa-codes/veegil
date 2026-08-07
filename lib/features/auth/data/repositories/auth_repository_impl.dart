import '../../../../core/storage/token_storage_service.dart';
import '../../domain/entities/auth_credentials.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';
import '../models/auth_response.dart';
import '../models/login_request.dart';
import '../models/signup_request.dart';
import '../utils/jwt_decoder.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required TokenStorageService tokenStorage,
  })  : _remoteDataSource = remoteDataSource,
        _tokenStorage = tokenStorage;

  final AuthRemoteDataSource _remoteDataSource;
  final TokenStorageService _tokenStorage;

  User? _cachedUser;

  @override
  Future<User> login(AuthCredentials credentials) async {
    final response = await _remoteDataSource.login(
      LoginRequest(
        phoneNumber: credentials.phoneNumber,
        password: credentials.password,
      ),
    );

    await _tokenStorage.saveToken(response.token);
    _cachedUser = _resolveUser(response, credentials.phoneNumber);
    return _cachedUser!;
  }

  @override
  Future<User> signup(AuthCredentials credentials) async {
    final response = await _remoteDataSource.signup(
      SignupRequest(
        phoneNumber: credentials.phoneNumber,
        password: credentials.password,
      ),
    );

    await _tokenStorage.saveToken(response.token);
    _cachedUser = _resolveUser(response, credentials.phoneNumber);
    return _cachedUser!;
  }

  @override
  Future<void> logout() async {
    _cachedUser = null;
    await _tokenStorage.deleteToken();
  }

  @override
  Future<bool> hasToken() => _tokenStorage.hasToken();

  @override
  Future<User?> getCurrentUser() async {
    if (_cachedUser != null) return _cachedUser;

    final token = await _tokenStorage.getToken();
    if (token == null || token.isEmpty) return null;

    _cachedUser = JwtDecoder.decodeUser(token);
    return _cachedUser;
  }

  User _resolveUser(AuthResponse response, String fallbackPhone) {
    if (response.user != null) {
      return response.user!.toEntity();
    }

    final decoded = JwtDecoder.decodeUser(response.token);
    if (decoded != null) {
      return decoded;
    }

    return User(id: fallbackPhone, phoneNumber: fallbackPhone);
  }
}
