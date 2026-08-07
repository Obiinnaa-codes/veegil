import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/entities/transaction_category.dart';
import '../../domain/entities/transaction_direction.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionModel with _$TransactionModel {
  const TransactionModel._();

  const factory TransactionModel({
    @JsonKey(readValue: _readId) required String id,
    @JsonKey(readValue: _readType) required String type,
    @JsonKey(readValue: _readAmount) required double amount,
    @JsonKey(readValue: _readPhoneNumber) required String phoneNumber,
    @JsonKey(readValue: _readCounterparty) String? counterparty,
    @JsonKey(readValue: _readBalance) double? balance,
    @JsonKey(readValue: _readNote) String? note,
    @JsonKey(readValue: _readCreated) DateTime? created,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Transaction toEntity() => Transaction(
        id: id,
        direction: _parseDirection(type),
        category: _parseCategory(note),
        amount: amount,
        phoneNumber: phoneNumber,
        counterparty: counterparty,
        balance: balance,
        note: note,
        created: created,
      );
}

TransactionDirection _parseDirection(String value) {
  switch (value.toLowerCase()) {
    case 'credit':
      return TransactionDirection.credit;
    case 'debit':
      return TransactionDirection.debit;
    default:
      return TransactionDirection.unknown;
  }
}

TransactionCategory _parseCategory(String? value) {
  switch (value?.toLowerCase()) {
    case 'deposit':
      return TransactionCategory.deposit;
    case 'withdraw':
    case 'withdrawal':
      return TransactionCategory.withdraw;
    case 'transfer':
      return TransactionCategory.transfer;
    default:
      return TransactionCategory.unknown;
  }
}

Object? _readId(Map<dynamic, dynamic> json, String key) {
  return json['id'] ?? json['_id'] ?? '';
}

Object? _readType(Map<dynamic, dynamic> json, String key) {
  return json['type'] ?? '';
}

Object? _readAmount(Map<dynamic, dynamic> json, String key) {
  final value = json['amount'];
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

Object? _readPhoneNumber(Map<dynamic, dynamic> json, String key) {
  return json['phoneNumber'] ?? json['phone_number'] ?? json['phone'] ?? '';
}

Object? _readCounterparty(Map<dynamic, dynamic> json, String key) {
  final value = json['counterparty'] ?? json['counter_party'];
  if (value is String && value.isNotEmpty) return value;
  return null;
}

Object? _readBalance(Map<dynamic, dynamic> json, String key) {
  final value = json['balance'];
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

Object? _readNote(Map<dynamic, dynamic> json, String key) {
  final value = json['note'] ?? json['description'];
  if (value is String && value.isNotEmpty) return value;
  return null;
}

Object? _readCreated(Map<dynamic, dynamic> json, String key) {
  final value = json['created'] ?? json['createdAt'] ?? json['created_at'];
  if (value is String && value.isNotEmpty) {
    return value;
  }
  return null;
}
