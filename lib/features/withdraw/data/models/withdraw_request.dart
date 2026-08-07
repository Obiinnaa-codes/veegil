import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdraw_request.freezed.dart';
part 'withdraw_request.g.dart';

@freezed
abstract class WithdrawRequest with _$WithdrawRequest {
  const factory WithdrawRequest({
    required int amount,
  }) = _WithdrawRequest;

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) =>
      _$WithdrawRequestFromJson(json);
}
