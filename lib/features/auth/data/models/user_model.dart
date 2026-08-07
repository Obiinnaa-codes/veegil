import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    @JsonKey(readValue: _readId) required String id,
    @JsonKey(name: 'phoneNumber', readValue: _readPhoneNumber)
    required String phoneNumber,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toEntity() => User(id: id, phoneNumber: phoneNumber);
}

Object? _readId(Map<dynamic, dynamic> json, String key) {
  return json['id'] ??
      json['_id'] ??
      json['userId'] ??
      json['user_id'] ??
      json['sub'] ??
      json['phoneNumber'] ??
      json['phone_number'] ??
      '';
}

Object? _readPhoneNumber(Map<dynamic, dynamic> json, String key) {
  return json['phoneNumber'] ??
      json['phone_number'] ??
      json['phone'] ??
      json['mobile'] ??
      '';
}
