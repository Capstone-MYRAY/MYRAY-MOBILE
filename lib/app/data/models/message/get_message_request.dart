import 'package:json_annotation/json_annotation.dart';

part 'get_message_request.g.dart';

@JsonSerializable()
class GetMessageRequest {
  String conventionId;

  GetMessageRequest({required this.conventionId});

  factory GetMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$GetMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetMessageRequestToJson(this);
}
