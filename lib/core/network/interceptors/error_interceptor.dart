import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../api_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('Dio error type: ${err.type}');
      debugPrint('Dio error: ${err.error}');
      debugPrint('Dio message: ${err.message}');
      debugPrint('Dio response: ${err.response?.data}');
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: _mapToApiException(err),
        message: err.message,
      ),
    );
  }

  ApiException _mapToApiException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const ApiException(
          userMessage: 'Request timed out. Please try again.',
        );
      case DioExceptionType.connectionError:
        return const ApiException(
          userMessage: 'No internet connection.',
        );
      case DioExceptionType.badResponse:
        return _mapStatusCode(err.response?.statusCode, err.response?.data);
      case DioExceptionType.cancel:
        return const ApiException(
          userMessage: 'Request was cancelled.',
        );
      case DioExceptionType.badCertificate:
        return const ApiException(
          userMessage: 'Secure connection failed. Please try again.',
        );
      case DioExceptionType.unknown:
        return _mapUnknownError(err);
    }
  }

  ApiException _mapUnknownError(DioException err) {
    final underlying = err.error;
    if (underlying is SocketException) {
      return const ApiException(
        userMessage: 'No internet connection.',
      );
    }
    if (underlying is HandshakeException) {
      return const ApiException(
        userMessage: 'Secure connection failed. Please try again.',
      );
    }
    if (underlying is FormatException) {
      return const ApiException(
        userMessage: 'Received an invalid response from the server.',
      );
    }

    return ApiException(
      userMessage: 'Something went wrong. Please try again.',
      originalError: err,
    );
  }

  ApiException _mapStatusCode(int? statusCode, dynamic data) {
    final serverMessage = _extractServerMessage(data);

    switch (statusCode) {
      case 400:
        return ApiException(
          userMessage: serverMessage ?? 'Invalid request.',
          statusCode: statusCode,
        );
      case 401:
        return ApiException(
          userMessage:
              serverMessage ?? 'Invalid phone number or password.',
          statusCode: statusCode,
        );
      case 404:
        return ApiException(
          userMessage: serverMessage ?? 'Service not found.',
          statusCode: statusCode,
        );
      case 500:
        return ApiException(
          userMessage: 'Something went wrong. Please try again.',
          statusCode: statusCode,
        );
      default:
        return ApiException(
          userMessage:
              serverMessage ?? 'Something went wrong. Please try again.',
          statusCode: statusCode,
        );
    }
  }

  String? _extractServerMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      for (final key in ['message', 'error', 'detail', 'msg']) {
        final value = data[key];
        if (value is String && value.isNotEmpty) {
          return value;
        }
      }
    }
    return null;
  }
}
