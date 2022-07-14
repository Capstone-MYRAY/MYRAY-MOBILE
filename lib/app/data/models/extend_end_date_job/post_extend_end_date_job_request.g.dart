// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_extend_end_date_job_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostExtendEndDateJobRequest _$PostExtendEndDateJobRequestFromJson(
        Map<String, dynamic> json) =>
    PostExtendEndDateJobRequest(
      jobPostId: json['job_post_id'] as int,
      extendEndDate: json['extend_end_date'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$PostExtendEndDateJobRequestToJson(
        PostExtendEndDateJobRequest instance) =>
    <String, dynamic>{
      'job_post_id': instance.jobPostId,
      'extend_end_date': instance.extendEndDate,
      'reason': instance.reason,
    };
