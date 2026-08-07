// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deposit_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DepositRequest {

 int get amount;
/// Create a copy of DepositRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepositRequestCopyWith<DepositRequest> get copyWith => _$DepositRequestCopyWithImpl<DepositRequest>(this as DepositRequest, _$identity);

  /// Serializes this DepositRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepositRequest&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'DepositRequest(amount: $amount)';
}


}

/// @nodoc
abstract mixin class $DepositRequestCopyWith<$Res>  {
  factory $DepositRequestCopyWith(DepositRequest value, $Res Function(DepositRequest) _then) = _$DepositRequestCopyWithImpl;
@useResult
$Res call({
 int amount
});




}
/// @nodoc
class _$DepositRequestCopyWithImpl<$Res>
    implements $DepositRequestCopyWith<$Res> {
  _$DepositRequestCopyWithImpl(this._self, this._then);

  final DepositRequest _self;
  final $Res Function(DepositRequest) _then;

/// Create a copy of DepositRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DepositRequest].
extension DepositRequestPatterns on DepositRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DepositRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DepositRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DepositRequest value)  $default,){
final _that = this;
switch (_that) {
case _DepositRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DepositRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DepositRequest() when $default != null:
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
case _DepositRequest() when $default != null:
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
case _DepositRequest():
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
case _DepositRequest() when $default != null:
return $default(_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DepositRequest implements DepositRequest {
  const _DepositRequest({required this.amount});
  factory _DepositRequest.fromJson(Map<String, dynamic> json) => _$DepositRequestFromJson(json);

@override final  int amount;

/// Create a copy of DepositRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepositRequestCopyWith<_DepositRequest> get copyWith => __$DepositRequestCopyWithImpl<_DepositRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DepositRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepositRequest&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'DepositRequest(amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$DepositRequestCopyWith<$Res> implements $DepositRequestCopyWith<$Res> {
  factory _$DepositRequestCopyWith(_DepositRequest value, $Res Function(_DepositRequest) _then) = __$DepositRequestCopyWithImpl;
@override @useResult
$Res call({
 int amount
});




}
/// @nodoc
class __$DepositRequestCopyWithImpl<$Res>
    implements _$DepositRequestCopyWith<$Res> {
  __$DepositRequestCopyWithImpl(this._self, this._then);

  final _DepositRequest _self;
  final $Res Function(_DepositRequest) _then;

/// Create a copy of DepositRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(_DepositRequest(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
