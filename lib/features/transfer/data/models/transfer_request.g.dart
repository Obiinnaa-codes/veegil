// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransferRequest _$TransferRequestFromJson(Map<String, dynamic> json) =>
    _TransferRequest(
      phoneNumber: json['phoneNumber'] as String,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$TransferRequestToJson(_TransferRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'amount': instance.amount,
    };
