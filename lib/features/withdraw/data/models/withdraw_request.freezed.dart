// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdraw_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WithdrawRequest {

 int get amount;
/// Create a copy of WithdrawRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WithdrawRequestCopyWith<WithdrawRequest> get copyWith => _$WithdrawRequestCopyWithImpl<WithdrawRequest>(this as WithdrawRequest, _$identity);

  /// Serializes this WithdrawRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WithdrawRequest&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'WithdrawRequest(amount: $amount)';
}


}

/// @nodoc
abstract mixin class $WithdrawRequestCopyWith<$Res>  {
  factory $WithdrawRequestCopyWith(WithdrawRequest value, $Res Function(WithdrawRequest) _then) = _$WithdrawRequestCopyWithImpl;
@useResult
$Res call({
 int amount
});




}
/// @nodoc
class _$WithdrawRequestCopyWithImpl<$Res>
    implements $WithdrawRequestCopyWith<$Res> {
  _$WithdrawRequestCopyWithImpl(this._self, this._then);

  final WithdrawRequest _self;
  final $Res Function(WithdrawRequest) _then;

/// Create a copy of WithdrawRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WithdrawRequest].
extension WithdrawRequestPatterns on WithdrawRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WithdrawRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WithdrawRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WithdrawRequest value)  $default,){
final _that = this;
switch (_that) {
case _WithdrawRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WithdrawRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WithdrawRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WithdrawRequest() when $default != null:
return $default(_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amount)  $default,) {final _that = this;
switch (_that) {
case _WithdrawRequest():
return $default(_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amount)?  $default,) {final _that = this;
switch (_that) {
case _WithdrawRequest() when $default != null:
return $default(_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WithdrawRequest implements WithdrawRequest {
  const _WithdrawRequest({required this.amount});
  factory _WithdrawRequest.fromJson(Map<String, dynamic> json) => _$WithdrawRequestFromJson(json);

@override final  int amount;

/// Create a copy of WithdrawRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WithdrawRequestCopyWith<_WithdrawRequest> get copyWith => __$WithdrawRequestCopyWithImpl<_WithdrawRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WithdrawRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WithdrawRequest&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'WithdrawRequest(amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$WithdrawRequestCopyWith<$Res> implements $WithdrawRequestCopyWith<$Res> {
  factory _$WithdrawRequestCopyWith(_WithdrawRequest value, $Res Function(_WithdrawRequest) _then) = __$WithdrawRequestCopyWithImpl;
@override @useResult
$Res call({
 int amount
});




}
/// @nodoc
class __$WithdrawRequestCopyWithImpl<$Res>
    implements _$WithdrawRequestCopyWith<$Res> {
  __$WithdrawRequestCopyWithImpl(this._self, this._then);

  final _WithdrawRequest _self;
  final $Res Function(_WithdrawRequest) _then;

/// Create a copy of WithdrawRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(_WithdrawRequest(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
