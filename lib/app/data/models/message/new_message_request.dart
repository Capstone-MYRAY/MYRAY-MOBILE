import 'package:json_annotation/json_annotation.dart';

part 'new_message_request.g.dart';

@JsonSerializable(includeIfNull: false)
class NewMessageRequest {
  @JsonKey(name: 'content')
  String? message;

  // @JsonKey(name: 'from_id')
  int fromId;

  // @JsonKey(name: 'to_id')
  int toId;

  // @JsonKey(name: 'job_post_id')
  int jobPostId;

  // @JsonKey(name: 'image_url')
  String? imgUrl;

  NewMessageRequest({
    required this.fromId,
    required this.toId,
    required this.jobPostId,
    this.message,
    this.imgUrl,
  });

  factory NewMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$NewMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NewMessageRequestToJson(this);
}
