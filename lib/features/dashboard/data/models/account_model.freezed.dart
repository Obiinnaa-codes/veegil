// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountModel {

@JsonKey(readValue: _readPhoneNumber) String get phoneNumber;@JsonKey(readValue: _readBalance) double get balance;@JsonKey(readValue: _readCreated) DateTime? get created;
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountModelCopyWith<AccountModel> get copyWith => _$AccountModelCopyWithImpl<AccountModel>(this as AccountModel, _$identity);

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountModel&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,balance,created);

@override
String toString() {
  return 'AccountModel(phoneNumber: $phoneNumber, balance: $balance, created: $created)';
}


}

/// @nodoc
abstract mixin class $AccountModelCopyWith<$Res>  {
  factory $AccountModelCopyWith(AccountModel value, $Res Function(AccountModel) _then) = _$AccountModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readPhoneNumber) String phoneNumber,@JsonKey(readValue: _readBalance) double balance,@JsonKey(readValue: _readCreated) DateTime? created
});




}
/// @nodoc
class _$AccountModelCopyWithImpl<$Res>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._self, this._then);

  final AccountModel _self;
  final $Res Function(AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? balance = null,Object? created = freezed,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountModel].
extension AccountModelPatterns on AccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readPhoneNumber)  String phoneNumber, @JsonKey(readValue: _readBalance)  double balance, @JsonKey(readValue: _readCreated)  DateTime? created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.phoneNumber,_that.balance,_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readPhoneNumber)  String phoneNumber, @JsonKey(readValue: _readBalance)  double balance, @JsonKey(readValue: _readCreated)  DateTime? created)  $default,) {final _that = this;
switch (_that) {
case _AccountModel():
return $default(_that.phoneNumber,_that.balance,_that.created);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readPhoneNumber)  String phoneNumber, @JsonKey(readValue: _readBalance)  double balance, @JsonKey(readValue: _readCreated)  DateTime? created)?  $default,) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.phoneNumber,_that.balance,_that.created);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountModel extends AccountModel {
  const _AccountModel({@JsonKey(readValue: _readPhoneNumber) required this.phoneNumber, @JsonKey(readValue: _readBalance) required this.balance, @JsonKey(readValue: _readCreated) this.created}): super._();
  factory _AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

@override@JsonKey(readValue: _readPhoneNumber) final  String phoneNumber;
@override@JsonKey(readValue: _readBalance) final  double balance;
@override@JsonKey(readValue: _readCreated) final  DateTime? created;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountModelCopyWith<_AccountModel> get copyWith => __$AccountModelCopyWithImpl<_AccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountModel&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,balance,created);

@override
String toString() {
  return 'AccountModel(phoneNumber: $phoneNumber, balance: $balance, created: $created)';
}


}

/// @nodoc
abstract mixin class _$AccountModelCopyWith<$Res> implements $AccountModelCopyWith<$Res> {
  factory _$AccountModelCopyWith(_AccountModel value, $Res Function(_AccountModel) _then) = __$AccountModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readPhoneNumber) String phoneNumber,@JsonKey(readValue: _readBalance) double balance,@JsonKey(readValue: _readCreated) DateTime? created
});




}
/// @nodoc
class __$AccountModelCopyWithImpl<$Res>
    implements _$AccountModelCopyWith<$Res> {
  __$AccountModelCopyWithImpl(this._self, this._then);

  final _AccountModel _self;
  final $Res Function(_AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? balance = null,Object? created = freezed,}) {
  return _then(_AccountModel(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
