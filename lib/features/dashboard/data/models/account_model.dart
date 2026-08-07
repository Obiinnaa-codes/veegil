import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/account.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
abstract class AccountModel with _$AccountModel {
  const AccountModel._();

  const factory AccountModel({
    @JsonKey(readValue: _readPhoneNumber) required String phoneNumber,
    @JsonKey(readValue: _readBalance) required double balance,
    @JsonKey(readValue: _readCreated) DateTime? created,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Account toEntity() => Account(
        phoneNumber: phoneNumber,
        balance: balance,
        created: created,
      );
}

Object? _readPhoneNumber(Map<dynamic, dynamic> json, String key) {
  return json['phoneNumber'] ??
      json['phone_number'] ??
      json['phone'] ??
      '';
}

Object? _readBalance(Map<dynamic, dynamic> json, String key) {
  final value = json['balance'];
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

Object? _readCreated(Map<dynamic, dynamic> json, String key) {
  final value = json['created'] ?? json['createdAt'] ?? json['created_at'];
  if (value is String && value.isNotEmpty) {
    return value;
  }
  return null;
}
