import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/page_meta.dart';

part 'page_meta_model.freezed.dart';
part 'page_meta_model.g.dart';

@freezed
abstract class PageMetaModel with _$PageMetaModel {
  const PageMetaModel._();

  const factory PageMetaModel({
    @JsonKey(readValue: _readTotal) @Default(0) int total,
    @JsonKey(readValue: _readLimit) @Default(50) int limit,
    @JsonKey(readValue: _readOffset) @Default(0) int offset,
    @JsonKey(readValue: _readHasMore) @Default(false) bool hasMore,
  }) = _PageMetaModel;

  factory PageMetaModel.fromJson(Map<String, dynamic> json) =>
      _$PageMetaModelFromJson(json);

  PageMeta toEntity() => PageMeta(
        total: total,
        limit: limit,
        offset: offset,
        hasMore: hasMore,
      );
}

Object? _readTotal(Map<dynamic, dynamic> json, String key) {
  final value = json['total'];
  if (value is int) return value;
  if (value is num) return value.toInt();
  return 0;
}

Object? _readLimit(Map<dynamic, dynamic> json, String key) {
  final value = json['limit'];
  if (value is int) return value;
  if (value is num) return value.toInt();
  return 50;
}

Object? _readOffset(Map<dynamic, dynamic> json, String key) {
  final value = json['offset'];
  if (value is int) return value;
  if (value is num) return value.toInt();
  return 0;
}

Object? _readHasMore(Map<dynamic, dynamic> json, String key) {
  final value = json['hasMore'] ?? json['has_more'];
  if (value is bool) return value;
  return false;
}

PageMetaModel pageMetaFromEnvelope(Map<String, dynamic>? meta) {
  if (meta == null) {
    return const PageMetaModel();
  }
  return PageMetaModel.fromJson(meta);
}
