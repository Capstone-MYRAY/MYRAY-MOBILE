// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int?,
      fromId: json['from_id'] as int,
      toId: json['to_id'] as int,
      jobPostId: json['job_post_id'] as int,
      createdDate: json['created_date'] == null
          ? null
          : DateTime.parse(json['created_date'] as String),
      conventionId: json['convention_id'] as String?,
      isRead: json['is_read'] as bool? ?? true,
      imgUrl: json['image_url'] as String?,
      message: json['content'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['from_id'] = instance.fromId;
  val['to_id'] = instance.toId;
  val['job_post_id'] = instance.jobPostId;
  writeNotNull('content', instance.message);
  writeNotNull('convention_id', instance.conventionId);
  writeNotNull('created_date', instance.createdDate?.toIso8601String());
  writeNotNull('image_url', instance.imgUrl);
  val['is_read'] = instance.isRead;
  return val;
}
