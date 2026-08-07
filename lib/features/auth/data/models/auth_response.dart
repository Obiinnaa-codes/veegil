import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

@freezed
abstract class AuthResponse with _$AuthResponse {
  const AuthResponse._();

  const factory AuthResponse({
    @JsonKey(readValue: _readToken) required String token,
    UserModel? user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

Object? _readToken(Map<dynamic, dynamic> json, String key) {
  return json['token'] ??
      json['accessToken'] ??
      json['access_token'] ??
      json['jwt'];
}
