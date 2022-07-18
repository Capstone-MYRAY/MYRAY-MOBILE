// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDetails _$MessageDetailsFromJson(Map<String, dynamic> json) =>
    MessageDetails(
      id: json['id'] as int,
      fromId: json['fromId'] as int,
      toId: json['toId'] as int,
      jobPostId: json['jobPostId'] as int,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      conventionId: json['conventionId'] as String?,
      isRead: json['isRead'] as bool? ?? true,
      imgUrl: json['imageUrl'] as String?,
      message: json['content'] as String?,
    );

Map<String, dynamic> _$MessageDetailsToJson(MessageDetails instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'fromId': instance.fromId,
    'toId': instance.toId,
    'jobPostId': instance.jobPostId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('content', instance.message);
  writeNotNull('conventionId', instance.conventionId);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('imageUrl', instance.imgUrl);
  val['isRead'] = instance.isRead;
  return val;
}
