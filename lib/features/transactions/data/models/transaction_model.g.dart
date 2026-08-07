// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      id: _readId(json, 'id') as String,
      type: _readType(json, 'type') as String,
      amount: (_readAmount(json, 'amount') as num).toDouble(),
      phoneNumber: _readPhoneNumber(json, 'phoneNumber') as String,
      counterparty: _readCounterparty(json, 'counterparty') as String?,
      balance: (_readBalance(json, 'balance') as num?)?.toDouble(),
      note: _readNote(json, 'note') as String?,
      created: _readCreated(json, 'created') == null
          ? null
          : DateTime.parse(_readCreated(json, 'created') as String),
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'amount': instance.amount,
      'phoneNumber': instance.phoneNumber,
      'counterparty': instance.counterparty,
      'balance': instance.balance,
      'note': instance.note,
      'created': instance.created?.toIso8601String(),
    };
