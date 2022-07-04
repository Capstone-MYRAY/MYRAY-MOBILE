// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_job_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppliedJobResponse _$AppliedJobResponseFromJson(Map<String, dynamic> json) =>
    AppliedJobResponse(
      id: json['id'] as int,
      jobPost: JobPost.fromJson(json['job_post'] as Map<String, dynamic>),
      appliedDate: DateTime.parse(json['applied_date'] as String),
      appliedByNavigation: Account.fromJson(
          json['applied_by_navigation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppliedJobResponseToJson(AppliedJobResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'job_post': instance.jobPost,
      'applied_date': instance.appliedDate.toIso8601String(),
      'applied_by_navigation': instance.appliedByNavigation,
    };
