// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileRequest(
      id: json['id'] as int,
      roleId: json['role_id'] as int,
      fullName: json['fullname'] as String,
      dob: DateTime.parse(json['date_of_birth'] as String),
      gender: json['gender'] as int,
      phone: json['phone_number'] as String,
      aboutMe: json['about_me'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      avatar: json['image_url'] as String?,
    );

Map<String, dynamic> _$UpdateProfileRequestToJson(
    UpdateProfileRequest instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'role_id': instance.roleId,
    'fullname': instance.fullName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('image_url', instance.avatar);
  val['date_of_birth'] = instance.dob.toIso8601String();
  val['gender'] = instance.gender;
  writeNotNull('address', instance.address);
  val['phone_number'] = instance.phone;
  writeNotNull('email', instance.email);
  writeNotNull('about_me', instance.aboutMe);
  return val;
}
