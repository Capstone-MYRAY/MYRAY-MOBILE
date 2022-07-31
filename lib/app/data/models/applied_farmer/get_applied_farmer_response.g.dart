// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_applied_farmer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAppliedFarmerResponse _$GetAppliedFarmerResponseFromJson(
        Map<String, dynamic> json) =>
    GetAppliedFarmerResponse(
      appliedFarmers: (json['list_object'] as List<dynamic>?)
          ?.map((e) => AppliedFarmer.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['paging_metadata'] == null
          ? null
          : PagingMetadata.fromJson(
              json['paging_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAppliedFarmerResponseToJson(
    GetAppliedFarmerResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'list_object', instance.appliedFarmers?.map((e) => e.toJson()).toList());
  writeNotNull('paging_metadata', instance.metadata?.toJson());
  return val;
}
