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
  @JsonValue('CreatedDate')
  createdDate,
}

enum JobPostSortColumn {
  @JsonValue('PublishedDate')
  publishedDate,

  @JsonValue('CreatedDate')
  createdDate,

  @JsonValue('ApprovedDate')
  approvedDate,
}

enum TreeTypeSortColumn {
  @JsonValue('Type')
  type,
}

enum PostTypeSortColumn {
  @JsonValue('Name')
  name,
  @JsonValue('Price')
  price,
  @JsonValue('Color')
  color,
}

enum PaymentHistorySortColumn {
  @JsonValue('ActualPrice')
  actualPrice,
  @JsonValue('UsedPoint')
  usedPoint,
  @JsonValue('EarnedPoint')
  earnedPoint,
  @JsonValue('Status')
  status,
}
