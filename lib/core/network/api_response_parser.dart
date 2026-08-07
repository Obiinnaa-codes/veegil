import 'package:dio/dio.dart';

import 'api_exception.dart';

Map<String, dynamic> parseApiEnvelope(Response<dynamic> response) {
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
    return payload;
  }

  if (payload == null) {
    throw const ApiException(
      userMessage: 'Unable to load your account.',
    );
  }

  return data;
}
