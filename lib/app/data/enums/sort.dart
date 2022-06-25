import 'package:json_annotation/json_annotation.dart';

enum SortOrder {
  @JsonValue('ASC')
  ascending,

  @JsonValue('DESC')
  descending
}

enum AreaSortColumn {
  @JsonValue('Province')
  province,

  @JsonValue('District')
  district,

  @JsonValue('Commune')
  commune,
}

enum GardenSortColumn {
  @JsonValue('AreaId')
  area,
  @JsonValue('Name')
  name,
  @JsonValue('LandArea')
  landArea,
  @JsonValue('CreateDate')
  createdDate,
}

enum JobPostSortColumn{
  @JsonValue('PublishedDate')
  publishedDate,

  @JsonValue('CreatedDate')
  createdDate,

  @JsonValue('ApprovedDate')
  approvedDate,
}
