import 'dart:convert';

import '../../domain/entities/user.dart';

abstract final class JwtDecoder {
  static User? decodeUser(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final normalized = base64Url.normalize(parts[1]);
      final payload = jsonDecode(utf8.decode(base64Url.decode(normalized)));

      if (payload is! Map<String, dynamic>) return null;

      final id = _readString(payload, const ['sub', 'id', 'userId', 'user_id']);
      final phoneNumber = _readString(
        payload,
        const ['phoneNumber', 'phone_number', 'phone', 'mobile'],
      );

      if (id == null && phoneNumber == null) return null;

      return User(
        id: id ?? phoneNumber ?? '',
        phoneNumber: phoneNumber ?? '',
      );
    } catch (_) {
      return null;
    }
  }

  static String? _readString(Map<String, dynamic> payload, List<String> keys) {
    for (final key in keys) {
      final value = payload[key];
      if (value != null) {
        return value.toString();
      }
    }
    return null;
  }
}
