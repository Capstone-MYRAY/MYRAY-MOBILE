// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewMessageRequest _$NewMessageRequestFromJson(Map<String, dynamic> json) =>
    NewMessageRequest(
      fromId: json['from_id'] as int,
      toId: json['to_id'] as int,
      jobPostId: json['job_post_id'] as int,
      message: json['content'] as String?,
      imgUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$NewMessageRequestToJson(NewMessageRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('content', instance.message);
  val['from_id'] = instance.fromId;
  val['to_id'] = instance.toId;
  val['job_post_id'] = instance.jobPostId;
  writeNotNull('image_url', instance.imgUrl);
  return val;
}
