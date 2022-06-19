import 'package:json_annotation/json_annotation.dart';

part 'paging_metadata.g.dart';

@JsonSerializable(includeIfNull: false)
class PagingMetadata {
  @JsonKey(name: 'page_index')
  int pageIndex;

  @JsonKey(name: 'page_size')
  int pageSize;

  @JsonKey(name: 'total_count')
  int totalCount;

  @JsonKey(name: 'total_pages')
  int totalPages;

  @JsonKey(name: 'has_previous_page')
  bool hasPreviousPage;

  @JsonKey(name: 'has_next_page')
  bool hasNextPage;

  PagingMetadata({
    this.pageIndex = 0,
    this.pageSize = 0,
    this.totalCount = 0,
    this.totalPages = 0,
    this.hasPreviousPage = false,
    this.hasNextPage = false,
  });

  factory PagingMetadata.fromJson(Map<String, dynamic> json) =>
      _$PagingMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$PagingMetadataToJson(this);
}
