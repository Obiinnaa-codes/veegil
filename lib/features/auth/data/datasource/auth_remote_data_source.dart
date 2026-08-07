import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
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
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const ApiException(
        userMessage: 'Received an invalid response from the server.',
      );
    }

    final status = data['status'];
    if (status == 'error') {
      final message = data['message'];
      throw ApiException(
        userMessage: message is String && message.isNotEmpty
            ? message
            : 'Something went wrong. Please try again.',
        statusCode: response.statusCode,
      );
    }

    final payload = data['data'];
    if (payload is Map<String, dynamic>) {
      return AuthResponse.fromJson(payload);
    }

    return AuthResponse.fromJson(data);
  }
}
