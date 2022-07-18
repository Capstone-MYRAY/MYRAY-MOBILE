// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmerMessage _$FarmerMessageFromJson(Map<String, dynamic> json) =>
    FarmerMessage(
      jobPostId: json['id'] as int,
      title: json['title'] as String,
      publishedId: json['publishedId'] as int,
      publishedName: json['publishedBy'] as String,
      avatar: json['avatarUrl'] as String?,
      createdDate: json['lastMessageTime'] == null
          ? null
          : DateTime.parse(json['lastMessageTime'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$FarmerMessageToJson(FarmerMessage instance) {
  final val = <String, dynamic>{
    'id': instance.jobPostId,
    'title': instance.title,
    'publishedId': instance.publishedId,
    'publishedBy': instance.publishedName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatarUrl', instance.avatar);
  writeNotNull('lastMessageTime', instance.createdDate?.toIso8601String());
  val['isRead'] = instance.isRead;
  return val;
}
