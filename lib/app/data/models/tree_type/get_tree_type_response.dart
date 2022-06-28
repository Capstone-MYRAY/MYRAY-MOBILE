import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
import 'package:myray_mobile/app/data/models/tree_type/tree_type.dart';

part 'get_tree_type_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class GetTreeTypeResponse {
  @JsonKey(name: 'list_object')
  List<TreeType>? treeTypes;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? metadata;

  GetTreeTypeResponse({
    this.treeTypes,
    this.metadata,
  });

  factory GetTreeTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTreeTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTreeTypeResponseToJson(this);
}
