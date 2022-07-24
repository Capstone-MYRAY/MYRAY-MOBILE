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
      sortColumn: $enumDecodeNullable(
          _$AppliedFarmerSortColumnEnumMap, json['sort-column']),
      orderBy: $enumDecodeNullable(_$SortOrderEnumMap, json['order-by']),
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
  writeNotNull(
      'sort-column', _$AppliedFarmerSortColumnEnumMap[instance.sortColumn]);
  writeNotNull('order-by', _$SortOrderEnumMap[instance.orderBy]);
  return val;
}

const _$AppliedFarmerStatusEnumMap = {
  AppliedFarmerStatus.pending: 'Pending',
  AppliedFarmerStatus.approved: 'Approve',
  AppliedFarmerStatus.rejected: 'Reject',
  AppliedFarmerStatus.end: 'End',
  AppliedFarmerStatus.fired: 'Fired',
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
