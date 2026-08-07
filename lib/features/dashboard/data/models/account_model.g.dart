// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      phoneNumber: _readPhoneNumber(json, 'phoneNumber') as String,
      balance: (_readBalance(json, 'balance') as num).toDouble(),
      created: _readCreated(json, 'created') == null
          ? null
          : DateTime.parse(_readCreated(json, 'created') as String),
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'balance': instance.balance,
      'created': instance.created?.toIso8601String(),
    };
