// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_end_date_job_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEndDateJobResponse _$UpdateEndDateJobResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateEndDateJobResponse(
      id: json['id'] as int,
      jobPostId: json['job_post_id'] as int,
      requestBy: json['request_by'] as int,
      extendEndDate: DateTime.parse(json['extend_end_date'] as String),
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$UpdateEndDateJobResponseToJson(
        UpdateEndDateJobResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'job_post_id': instance.jobPostId,
      'request_by': instance.requestBy,
      'extend_end_date': instance.extendEndDate.toIso8601String(),
      'reason': instance.reason,
    };
