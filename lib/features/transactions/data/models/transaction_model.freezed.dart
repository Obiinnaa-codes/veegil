// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionModel {

@JsonKey(readValue: _readId) String get id;@JsonKey(readValue: _readType) String get type;@JsonKey(readValue: _readAmount) double get amount;@JsonKey(readValue: _readPhoneNumber) String get phoneNumber;@JsonKey(readValue: _readCounterparty) String? get counterparty;@JsonKey(readValue: _readBalance) double? get balance;@JsonKey(readValue: _readNote) String? get note;@JsonKey(readValue: _readCreated) DateTime? get created;
/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<TransactionModel> get copyWith => _$TransactionModelCopyWithImpl<TransactionModel>(this as TransactionModel, _$identity);

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.counterparty, counterparty) || other.counterparty == counterparty)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.note, note) || other.note == note)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,phoneNumber,counterparty,balance,note,created);

@override
String toString() {
  return 'TransactionModel(id: $id, type: $type, amount: $amount, phoneNumber: $phoneNumber, counterparty: $counterparty, balance: $balance, note: $note, created: $created)';
}


}

/// @nodoc
abstract mixin class $TransactionModelCopyWith<$Res>  {
  factory $TransactionModelCopyWith(TransactionModel value, $Res Function(TransactionModel) _then) = _$TransactionModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readId) String id,@JsonKey(readValue: _readType) String type,@JsonKey(readValue: _readAmount) double amount,@JsonKey(readValue: _readPhoneNumber) String phoneNumber,@JsonKey(readValue: _readCounterparty) String? counterparty,@JsonKey(readValue: _readBalance) double? balance,@JsonKey(readValue: _readNote) String? note,@JsonKey(readValue: _readCreated) DateTime? created
});




}
/// @nodoc
class _$TransactionModelCopyWithImpl<$Res>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._self, this._then);

  final TransactionModel _self;
  final $Res Function(TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? phoneNumber = null,Object? counterparty = freezed,Object? balance = freezed,Object? note = freezed,Object? created = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,counterparty: freezed == counterparty ? _self.counterparty : counterparty // ignore: cast_nullable_to_non_nullable
as String?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionModel].
extension TransactionModelPatterns on TransactionModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _TransactionModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readId)  String id, @JsonKey(readValue: _readType)  String type, @JsonKey(readValue: _readAmount)  double amount, @JsonKey(readValue: _readPhoneNumber)  String phoneNumber, @JsonKey(readValue: _readCounterparty)  String? counterparty, @JsonKey(readValue: _readBalance)  double? balance, @JsonKey(readValue: _readNote)  String? note, @JsonKey(readValue: _readCreated)  DateTime? created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.phoneNumber,_that.counterparty,_that.balance,_that.note,_that.created);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readId)  String id, @JsonKey(readValue: _readType)  String type, @JsonKey(readValue: _readAmount)  double amount, @JsonKey(readValue: _readPhoneNumber)  String phoneNumber, @JsonKey(readValue: _readCounterparty)  String? counterparty, @JsonKey(readValue: _readBalance)  double? balance, @JsonKey(readValue: _readNote)  String? note, @JsonKey(readValue: _readCreated)  DateTime? created)  $default,) {final _that = this;
switch (_that) {
case _TransactionModel():
return $default(_that.id,_that.type,_that.amount,_that.phoneNumber,_that.counterparty,_that.balance,_that.note,_that.created);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readId)  String id, @JsonKey(readValue: _readType)  String type, @JsonKey(readValue: _readAmount)  double amount, @JsonKey(readValue: _readPhoneNumber)  String phoneNumber, @JsonKey(readValue: _readCounterparty)  String? counterparty, @JsonKey(readValue: _readBalance)  double? balance, @JsonKey(readValue: _readNote)  String? note, @JsonKey(readValue: _readCreated)  DateTime? created)?  $default,) {final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.phoneNumber,_that.counterparty,_that.balance,_that.note,_that.created);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionModel extends TransactionModel {
  const _TransactionModel({@JsonKey(readValue: _readId) required this.id, @JsonKey(readValue: _readType) required this.type, @JsonKey(readValue: _readAmount) required this.amount, @JsonKey(readValue: _readPhoneNumber) required this.phoneNumber, @JsonKey(readValue: _readCounterparty) this.counterparty, @JsonKey(readValue: _readBalance) this.balance, @JsonKey(readValue: _readNote) this.note, @JsonKey(readValue: _readCreated) this.created}): super._();
  factory _TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

@override@JsonKey(readValue: _readId) final  String id;
@override@JsonKey(readValue: _readType) final  String type;
@override@JsonKey(readValue: _readAmount) final  double amount;
@override@JsonKey(readValue: _readPhoneNumber) final  String phoneNumber;
@override@JsonKey(readValue: _readCounterparty) final  String? counterparty;
@override@JsonKey(readValue: _readBalance) final  double? balance;
@override@JsonKey(readValue: _readNote) final  String? note;
@override@JsonKey(readValue: _readCreated) final  DateTime? created;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionModelCopyWith<_TransactionModel> get copyWith => __$TransactionModelCopyWithImpl<_TransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.counterparty, counterparty) || other.counterparty == counterparty)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.note, note) || other.note == note)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,phoneNumber,counterparty,balance,note,created);

@override
String toString() {
  return 'TransactionModel(id: $id, type: $type, amount: $amount, phoneNumber: $phoneNumber, counterparty: $counterparty, balance: $balance, note: $note, created: $created)';
}


}

/// @nodoc
abstract mixin class _$TransactionModelCopyWith<$Res> implements $TransactionModelCopyWith<$Res> {
  factory _$TransactionModelCopyWith(_TransactionModel value, $Res Function(_TransactionModel) _then) = __$TransactionModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readId) String id,@JsonKey(readValue: _readType) String type,@JsonKey(readValue: _readAmount) double amount,@JsonKey(readValue: _readPhoneNumber) String phoneNumber,@JsonKey(readValue: _readCounterparty) String? counterparty,@JsonKey(readValue: _readBalance) double? balance,@JsonKey(readValue: _readNote) String? note,@JsonKey(readValue: _readCreated) DateTime? created
});




}
/// @nodoc
class __$TransactionModelCopyWithImpl<$Res>
    implements _$TransactionModelCopyWith<$Res> {
  __$TransactionModelCopyWithImpl(this._self, this._then);

  final _TransactionModel _self;
  final $Res Function(_TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? phoneNumber = null,Object? counterparty = freezed,Object? balance = freezed,Object? note = freezed,Object? created = freezed,}) {
  return _then(_TransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,counterparty: freezed == counterparty ? _self.counterparty : counterparty // ignore: cast_nullable_to_non_nullable
as String?,balance: freezed == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
