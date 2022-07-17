// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmerMessage _$FarmerMessageFromJson(Map<String, dynamic> json) =>
    FarmerMessage(
      jobPostId: json['Id'] as int,
      title: json['Title'] as String,
      publishedId: json['PublishedId'] as int,
      publishedName: json['PublishedBy'] as String,
      avatar: json['AvatarUrl'] as String?,
      createdDate: json['LastMessageTime'] == null
          ? null
          : DateTime.parse(json['LastMessageTime'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$FarmerMessageToJson(FarmerMessage instance) {
  final val = <String, dynamic>{
    'Id': instance.jobPostId,
    'Title': instance.title,
    'PublishedId': instance.publishedId,
    'PublishedBy': instance.publishedName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AvatarUrl', instance.avatar);
  writeNotNull('LastMessageTime', instance.createdDate?.toIso8601String());
  val['isRead'] = instance.isRead;
  return val;
}
