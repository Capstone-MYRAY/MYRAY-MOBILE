import 'package:json_annotation/json_annotation.dart';

part 'extend_expired_date_request.g.dart';

@JsonSerializable(includeIfNull: false)
class ExtendExpiredDateRequest {
  @JsonKey(name: 'jobPostId')
  String jobPostId;

  @JsonKey(name: 'extendDate')
  DateTime newExpiredDate;

  @JsonKey(name: 'usePoint')
  String? usedPoint;

  ExtendExpiredDateRequest({
    required this.jobPostId,
    required this.newExpiredDate,
    this.usedPoint,
  });

  factory ExtendExpiredDateRequest.fromJson(Map<String, dynamic> json) =>
      _$ExtendExpiredDateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendExpiredDateRequestToJson(this);
}
