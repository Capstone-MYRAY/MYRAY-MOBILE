// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_specific_feedback_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSpecificFeedbackRequest _$GetSpecificFeedbackRequestFromJson(
        Map<String, dynamic> json) =>
    GetSpecificFeedbackRequest(
      jobPostId: json['jobPostId'] as String,
      belongedId: json['belongedId'] as String,
      createdById: json['createdById'] as String,
    );

Map<String, dynamic> _$GetSpecificFeedbackRequestToJson(
        GetSpecificFeedbackRequest instance) =>
    <String, dynamic>{
      'jobPostId': instance.jobPostId,
      'belongedId': instance.belongedId,
      'createdById': instance.createdById,
    };
