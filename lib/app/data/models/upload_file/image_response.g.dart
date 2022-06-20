// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResponse _$ImageResponseFromJson(Map<String, dynamic> json) =>
    ImageResponse(
      fileName: json['filename'] as String,
      oldName: json['oldname'] as String,
      link: json['link'] as String,
      size: json['size'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ImageResponseToJson(ImageResponse instance) =>
    <String, dynamic>{
      'filename': instance.fileName,
      'oldname': instance.oldName,
      'link': instance.link,
      'size': instance.size,
      'type': instance.type,
    };
