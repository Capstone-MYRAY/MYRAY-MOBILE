// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as int?,
      roleId: json['role_id'] as int?,
      fullName: json['fullname'] as String?,
      imageUrl: json['image_url'] as String?,
      gender: json['gender'] as int?,
      address: json['address'] as String?,
      dob: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      balance: json['balance'] as int? ?? 0,
      point: json['point'] as int? ?? 0,
      aboutMe: json['about_me'] as String?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('role_id', instance.roleId);
  writeNotNull('fullname', instance.fullName);
  writeNotNull('image_url', instance.imageUrl);
  writeNotNull('date_of_birth', instance.dob?.toIso8601String());
  writeNotNull('gender', instance.gender);
  writeNotNull('address', instance.address);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('email', instance.email);
  writeNotNull('balance', instance.balance);
  writeNotNull('point', instance.point);
  writeNotNull('about_me', instance.aboutMe);
  return val;
}
