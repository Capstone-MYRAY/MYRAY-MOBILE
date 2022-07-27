// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_specific_report_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSpecificReportRequest _$GetSpecificReportRequestFromJson(
        Map<String, dynamic> json) =>
    GetSpecificReportRequest(
      jobPostId: json['jobPostId'] as String,
      reportedId: json['reportedId'] as String,
      createdById: json['createById'] as String,
    );

Map<String, dynamic> _$GetSpecificReportRequestToJson(
        GetSpecificReportRequest instance) =>
    <String, dynamic>{
      'jobPostId': instance.jobPostId,
      'reportedId': instance.reportedId,
      'createById': instance.createdById,
    };
