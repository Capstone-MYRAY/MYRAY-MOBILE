import 'package:json_annotation/json_annotation.dart';

part 'get_max_pin_day_request.g.dart';

@JsonSerializable()
class GetMaxPinDayRequest {
  @JsonKey(name: 'pinDate')
  DateTime pinDate;

  // @JsonKey(name: 'numberPublishDay')
  // String numOfPublishDay;

  @JsonKey(name: 'postTypeId')
  String postTypeId;

  GetMaxPinDayRequest({
    required this.pinDate,
    // required this.numOfPublishDay,
    required this.postTypeId,
  });

  factory GetMaxPinDayRequest.fromJson(Map<String, dynamic> json) =>
      _$GetMaxPinDayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetMaxPinDayRequestToJson(this);
}
