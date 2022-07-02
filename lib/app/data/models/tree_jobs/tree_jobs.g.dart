// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_jobs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeJobs _$TreeJobsFromJson(Map<String, dynamic> json) => TreeJobs(
      treeTypeId: json['tree_type_id'] as int,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$TreeJobsToJson(TreeJobs instance) {
  final val = <String, dynamic>{
    'tree_type_id': instance.treeTypeId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  return val;
}
