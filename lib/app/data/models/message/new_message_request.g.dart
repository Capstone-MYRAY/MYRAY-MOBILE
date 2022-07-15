// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewMessageRequest _$NewMessageRequestFromJson(Map<String, dynamic> json) =>
    NewMessageRequest(
      fromId: json['fromId'] as int,
      toId: json['toId'] as int,
      jobPostId: json['jobPostId'] as int,
      message: json['content'] as String?,
      imgUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$NewMessageRequestToJson(NewMessageRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('content', instance.message);
  val['fromId'] = instance.fromId;
  val['toId'] = instance.toId;
  val['jobPostId'] = instance.jobPostId;
  writeNotNull('imageUrl', instance.imgUrl);
  return val;
}
