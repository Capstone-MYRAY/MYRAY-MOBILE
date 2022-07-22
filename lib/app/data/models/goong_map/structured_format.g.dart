// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'structured_format.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StructuredFormat _$StructuredFormatFromJson(Map<String, dynamic> json) =>
    StructuredFormat(
      mainText: json['main_text'] as String,
      secondaryText: json['secondary_text'] as String,
    );

Map<String, dynamic> _$StructuredFormatToJson(StructuredFormat instance) =>
    <String, dynamic>{
      'main_text': instance.mainText,
      'secondary_text': instance.secondaryText,
    };
