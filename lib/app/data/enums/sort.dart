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
