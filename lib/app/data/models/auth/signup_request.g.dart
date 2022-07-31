// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest(
      roleId: json['role_id'] as int?,
      fullName: json['fullname'] as String?,
      dob: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      phoneNumber: json['phone_number'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'role_id': instance.roleId,
      'fullname': instance.fullName,
      'date_of_birth': instance.dob?.toIso8601String(),
      'phone_number': instance.phoneNumber,
      'password': instance.password,
    };
