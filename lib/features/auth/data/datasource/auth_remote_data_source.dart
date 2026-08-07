import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response_parser.dart';
import '../models/auth_response.dart';
import '../models/login_request.dart';
import '../models/signup_request.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<AuthResponse> login(LoginRequest request) async {
    final response = await _apiClient.post<dynamic>(
      '/auth/login',
      data: request.toJson(),
    );

    return _parseResponse(response);
  }

  Future<AuthResponse> signup(SignupRequest request) async {
    final response = await _apiClient.post<dynamic>(
      '/auth/signup',
      data: request.toJson(),
    );

    return _parseResponse(response);
  }

  AuthResponse _parseResponse(Response<dynamic> response) {
    final payload = parseApiEnvelope(response);
    return AuthResponse.fromJson(payload);
  }
}
