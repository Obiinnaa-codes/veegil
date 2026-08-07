import 'package:freezed_annotation/freezed_annotation.dart';

part 'deposit_request.freezed.dart';
part 'deposit_request.g.dart';

@freezed
abstract class DepositRequest with _$DepositRequest {
  const factory DepositRequest({
    required int amount,
  }) = _DepositRequest;

  factory DepositRequest.fromJson(Map<String, dynamic> json) =>
      _$DepositRequestFromJson(json);
}
