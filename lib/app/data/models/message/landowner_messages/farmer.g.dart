// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Farmer _$FarmerFromJson(Map<String, dynamic> json) => Farmer(
      id: json['id'] as int,
      name: json['name'] as String,
      conventionId: json['conventionId'] as String,
      latMessage:
          MessageDetails.fromJson(json['latMessage'] as Map<String, dynamic>),
      avatar: json['image'] as String?,
    );

Map<String, dynamic> _$FarmerToJson(Farmer instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('image', instance.avatar);
  val['conventionId'] = instance.conventionId;
  val['latMessage'] = instance.latMessage.toJson();
  return val;
}
