// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_farmer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppliedFarmer _$AppliedFarmerFromJson(Map<String, dynamic> json) =>
    AppliedFarmer(
      id: json['id'] as int,
      jobPost: JobPost.fromJson(json['job_post'] as Map<String, dynamic>),
      userInfo: Account.fromJson(
          json['applied_by_navigation'] as Map<String, dynamic>),
      appliedDate: DateTime.parse(json['applied_date'] as String),
      status: json['status'] as int,
    );

Map<String, dynamic> _$AppliedFarmerToJson(AppliedFarmer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'job_post': instance.jobPost.toJson(),
      'applied_date': instance.appliedDate.toIso8601String(),
      'applied_by_navigation': instance.userInfo.toJson(),
      'status': instance.status,
    };
