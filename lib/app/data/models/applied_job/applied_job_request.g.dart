// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_job_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppliedJobRequest _$AppliedJobRequestFromJson(Map<String, dynamic> json) =>
    AppliedJobRequest(
      status: $enumDecodeNullable(_$AppliedJobStatusEnumMap, json['status']),
      startWork: json['startWork'] as String?,
      page: json['page'] as String,
      pageSize: json['page-size'] as String,
    );

Map<String, dynamic> _$AppliedJobRequestToJson(AppliedJobRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', _$AppliedJobStatusEnumMap[instance.status]);
  val['page'] = instance.page;
  val['page-size'] = instance.pageSize;
  writeNotNull('startWork', instance.startWork);
  return val;
}

const _$AppliedJobStatusEnumMap = {
  AppliedJobStatus.pending: 'pending',
  AppliedJobStatus.approve: 'approve',
  AppliedJobStatus.reject: 'reject',
  AppliedJobStatus.end: 'end',
};
