// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_meta_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageMetaModel {

@JsonKey(readValue: _readTotal) int get total;@JsonKey(readValue: _readLimit) int get limit;@JsonKey(readValue: _readOffset) int get offset;@JsonKey(readValue: _readHasMore) bool get hasMore;
/// Create a copy of PageMetaModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageMetaModelCopyWith<PageMetaModel> get copyWith => _$PageMetaModelCopyWithImpl<PageMetaModel>(this as PageMetaModel, _$identity);

  /// Serializes this PageMetaModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageMetaModel&&(identical(other.total, total) || other.total == total)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,limit,offset,hasMore);

@override
String toString() {
  return 'PageMetaModel(total: $total, limit: $limit, offset: $offset, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $PageMetaModelCopyWith<$Res>  {
  factory $PageMetaModelCopyWith(PageMetaModel value, $Res Function(PageMetaModel) _then) = _$PageMetaModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _readTotal) int total,@JsonKey(readValue: _readLimit) int limit,@JsonKey(readValue: _readOffset) int offset,@JsonKey(readValue: _readHasMore) bool hasMore
});




}
/// @nodoc
class _$PageMetaModelCopyWithImpl<$Res>
    implements $PageMetaModelCopyWith<$Res> {
  _$PageMetaModelCopyWithImpl(this._self, this._then);

  final PageMetaModel _self;
  final $Res Function(PageMetaModel) _then;

/// Create a copy of PageMetaModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? limit = null,Object? offset = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PageMetaModel].
extension PageMetaModelPatterns on PageMetaModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageMetaModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageMetaModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageMetaModel value)  $default,){
final _that = this;
switch (_that) {
case _PageMetaModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageMetaModel value)?  $default,){
final _that = this;
switch (_that) {
case _PageMetaModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readTotal)  int total, @JsonKey(readValue: _readLimit)  int limit, @JsonKey(readValue: _readOffset)  int offset, @JsonKey(readValue: _readHasMore)  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageMetaModel() when $default != null:
return $default(_that.total,_that.limit,_that.offset,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _readTotal)  int total, @JsonKey(readValue: _readLimit)  int limit, @JsonKey(readValue: _readOffset)  int offset, @JsonKey(readValue: _readHasMore)  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _PageMetaModel():
return $default(_that.total,_that.limit,_that.offset,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _readTotal)  int total, @JsonKey(readValue: _readLimit)  int limit, @JsonKey(readValue: _readOffset)  int offset, @JsonKey(readValue: _readHasMore)  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _PageMetaModel() when $default != null:
return $default(_that.total,_that.limit,_that.offset,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageMetaModel extends PageMetaModel {
  const _PageMetaModel({@JsonKey(readValue: _readTotal) this.total = 0, @JsonKey(readValue: _readLimit) this.limit = 50, @JsonKey(readValue: _readOffset) this.offset = 0, @JsonKey(readValue: _readHasMore) this.hasMore = false}): super._();
  factory _PageMetaModel.fromJson(Map<String, dynamic> json) => _$PageMetaModelFromJson(json);

@override@JsonKey(readValue: _readTotal) final  int total;
@override@JsonKey(readValue: _readLimit) final  int limit;
@override@JsonKey(readValue: _readOffset) final  int offset;
@override@JsonKey(readValue: _readHasMore) final  bool hasMore;

/// Create a copy of PageMetaModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageMetaModelCopyWith<_PageMetaModel> get copyWith => __$PageMetaModelCopyWithImpl<_PageMetaModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageMetaModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageMetaModel&&(identical(other.total, total) || other.total == total)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,limit,offset,hasMore);

@override
String toString() {
  return 'PageMetaModel(total: $total, limit: $limit, offset: $offset, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$PageMetaModelCopyWith<$Res> implements $PageMetaModelCopyWith<$Res> {
  factory _$PageMetaModelCopyWith(_PageMetaModel value, $Res Function(_PageMetaModel) _then) = __$PageMetaModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _readTotal) int total,@JsonKey(readValue: _readLimit) int limit,@JsonKey(readValue: _readOffset) int offset,@JsonKey(readValue: _readHasMore) bool hasMore
});




}
/// @nodoc
class __$PageMetaModelCopyWithImpl<$Res>
    implements _$PageMetaModelCopyWith<$Res> {
  __$PageMetaModelCopyWithImpl(this._self, this._then);

  final _PageMetaModel _self;
  final $Res Function(_PageMetaModel) _then;

/// Create a copy of PageMetaModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? limit = null,Object? offset = null,Object? hasMore = null,}) {
  return _then(_PageMetaModel(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
