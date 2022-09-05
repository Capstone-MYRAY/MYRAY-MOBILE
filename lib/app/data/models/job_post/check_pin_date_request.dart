import 'package:json_annotation/json_annotation.dart';

part 'check_pin_date_request.g.dart';

@JsonSerializable()
class CheckPinDateRequest {
  @JsonKey(name: 'PublishedDate')
  DateTime publishedDate;

  // @JsonKey(name: 'numberOfDayPublish')
  // String numOfPublishDay;

  @JsonKey(name: 'postTypeId')
  String postTypeId;

  CheckPinDateRequest({
    required this.publishedDate,
    // required this.numOfPublishDay,
    required this.postTypeId,
  });

  factory CheckPinDateRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckPinDateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPinDateRequestToJson(this);
}
