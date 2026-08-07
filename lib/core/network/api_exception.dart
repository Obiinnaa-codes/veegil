class ApiException implements Exception {
  const ApiException({
    required this.userMessage,
    this.statusCode,
    this.originalError,
  });

  final String userMessage;
  final int? statusCode;
  final Object? originalError;

  @override
  String toString() => userMessage;
}
