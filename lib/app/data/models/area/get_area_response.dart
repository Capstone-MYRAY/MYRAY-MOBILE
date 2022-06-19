import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/area/area.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';

part 'get_area_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class GetAreaResponse {
  @JsonKey(name: 'list_object')
  List<Area>? areas;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? metadata;

  GetAreaResponse({
    this.areas,
    this.metadata,
  });

  factory GetAreaResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAreaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAreaResponseToJson(this);
}
