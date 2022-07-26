
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/guidepost/guidepost.dart';
import 'package:myray_mobile/app/data/models/paging_metadata.dart';
part 'get_guidepost_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetGuidepostResponse{

  @JsonKey(name: 'list_object')
  List<Guidepost>? listObject;

  @JsonKey(name: 'paging_metadata')
  PagingMetadata? pagingMetadata;

  GetGuidepostResponse({
    this.listObject,
    this.pagingMetadata
  });

  factory GetGuidepostResponse.fromJson(Map<String, dynamic> json) => _$GetGuidepostResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetGuidepostResponseToJson(this);
}