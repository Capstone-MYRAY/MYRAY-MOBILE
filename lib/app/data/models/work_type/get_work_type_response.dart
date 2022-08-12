import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
import 'package:myray_mobile/app/data/models/work_type/work_type.dart';

part 'get_work_type_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetWorkTypeResponse {
  @JsonKey(name: 'list_object')
  List<WorkType> workTypes;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata metadata;

  GetWorkTypeResponse({
    required this.workTypes,
    required this.metadata,
  });

  factory GetWorkTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetWorkTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetWorkTypeResponseToJson(this);
}
