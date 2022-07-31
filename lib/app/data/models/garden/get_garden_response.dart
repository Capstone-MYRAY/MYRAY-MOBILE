import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';

part 'get_garden_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetGardenResponse {
  @JsonKey(name: 'list_object')
  List<Garden>? gardens;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? metadata;

  GetGardenResponse({
    this.gardens,
    this.metadata,
  });

  factory GetGardenResponse.fromJson(Map<String, dynamic> json) =>
      _$GetGardenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetGardenResponseToJson(this);
}
