// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_applied_farmer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAppliedFarmerRequest _$GetAppliedFarmerRequestFromJson(
        Map<String, dynamic> json) =>
    GetAppliedFarmerRequest(
      page: json['page'] as String,
      pageSize: json['page-size'] as String,
      status: $enumDecodeNullable(_$AppliedFarmerStatusEnumMap, json['status']),
      jobPostId: json['startWork'] as String?,
    );

Map<String, dynamic> _$GetAppliedFarmerRequestToJson(
    GetAppliedFarmerRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', _$AppliedFarmerStatusEnumMap[instance.status]);
  val['page'] = instance.page;
  val['page-size'] = instance.pageSize;
  writeNotNull('startWork', instance.jobPostId);
  return val;
}

const _$AppliedFarmerStatusEnumMap = {
  AppliedFarmerStatus.pending: 'Pending',
  AppliedFarmerStatus.approve: 'Approve',
  AppliedFarmerStatus.reject: 'Reject',
  AppliedFarmerStatus.end: 'End',
};
