import 'package:dio/dio.dart';

import '../network/api_client.dart';
import '../network/api_exception.dart';

abstract final class ApiErrorMapper {
  static bool isUnauthorized(Object error) {
    if (error is DioException) {
      return error.response?.statusCode == 401 ||
          error.apiException.statusCode == 401;
    }
    if (error is ApiException) {
      return error.statusCode == 401;
    }
    return false;
  }

  static String mapError(Object error) {
    if (error is DioException) {
      return error.apiException.userMessage;
    }
    if (error is ApiException) {
      return error.userMessage;
    }
    return 'Something went wrong. Please try again.';
  }
}
