// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_applied_job_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAppliedJobRequest _$GetAppliedJobRequestFromJson(
        Map<String, dynamic> json) =>
    GetAppliedJobRequest(
      status: $enumDecodeNullable(_$AppliedFarmerStatusEnumMap, json['status']),
      startWork: json['startWork'] as String?,
      sortColumn: $enumDecodeNullable(
          _$AppliedFarmerSortColumnEnumMap, json['sort-column']),
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
      page: json['page'] as String,
      pageSize: json['page-size'] as String,
    );

Map<String, dynamic> _$GetAppliedJobRequestToJson(
    GetAppliedJobRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', _$AppliedFarmerStatusEnumMap[instance.status]);
  val['page'] = instance.page;
  val['page-size'] = instance.pageSize;
  writeNotNull(
      'sort-column', _$AppliedFarmerSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  writeNotNull('startWork', instance.startWork);
  return val;
}

const _$AppliedFarmerStatusEnumMap = {
  AppliedFarmerStatus.pending: 'Pending',
  AppliedFarmerStatus.approved: 'Approve',
  AppliedFarmerStatus.rejected: 'Reject',
  AppliedFarmerStatus.end: 'End',
};

const _$AppliedFarmerSortColumnEnumMap = {
  AppliedFarmerSortColumn.appliedDate: 'AppliedDate',
  AppliedFarmerSortColumn.approvedDate: 'ApprovedDate',
  AppliedFarmerSortColumn.startDate: 'StartDate',
  AppliedFarmerSortColumn.endDate: 'EndDate',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ASC',
  SortOrder.descending: 'DESC',
};
