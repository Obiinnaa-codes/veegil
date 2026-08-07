// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_meta_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PageMetaModel _$PageMetaModelFromJson(Map<String, dynamic> json) =>
    _PageMetaModel(
      total: (_readTotal(json, 'total') as num?)?.toInt() ?? 0,
      limit: (_readLimit(json, 'limit') as num?)?.toInt() ?? 50,
      offset: (_readOffset(json, 'offset') as num?)?.toInt() ?? 0,
      hasMore: _readHasMore(json, 'hasMore') as bool? ?? false,
    );

Map<String, dynamic> _$PageMetaModelToJson(_PageMetaModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'limit': instance.limit,
      'offset': instance.offset,
      'hasMore': instance.hasMore,
    };
