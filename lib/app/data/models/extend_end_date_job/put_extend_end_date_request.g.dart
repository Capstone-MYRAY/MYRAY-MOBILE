// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_extend_end_date_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutExtendEndDateRequest _$PutExtendEndDateRequestFromJson(
        Map<String, dynamic> json) =>
    PutExtendEndDateRequest(
      id: json['id'] as String,
      jobPostId: json['job_post_id'] as int,
      extendEndDate: json['extend_end_date'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$PutExtendEndDateRequestToJson(
        PutExtendEndDateRequest instance) =>
    <String, dynamic>{
      'job_post_id': instance.jobPostId,
      'extend_end_date': instance.extendEndDate,
      'reason': instance.reason,
      'id': instance.id,
    };
