import 'package:json_annotation/json_annotation.dart';

part 'tree_jobs.g.dart';

@JsonSerializable(includeIfNull: false)
class TreeJobs {
  @JsonKey(name: 'tree_type_id')
  int treeTypeId;

  @JsonKey(name: 'type')
  String? type;

  TreeJobs({required this.treeTypeId, this.type});

  factory TreeJobs.fromJson(Map<String, dynamic> json) =>
      _$TreeJobsFromJson(json);

  Map<String, dynamic> toJson() => _$TreeJobsToJson(this);
}
