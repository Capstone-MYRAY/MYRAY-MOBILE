import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/goong_map/structured_format.dart';

part 'places_autocomplete.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class PlacesAutocomplete {
  @JsonKey(name: 'description')
  String address;

  @JsonKey(name: 'place_id')
  String placeId;

  @JsonKey(name: 'structured_formatting')
  StructuredFormat structuredFormat;

  PlacesAutocomplete({
    required this.address,
    required this.placeId,
    required this.structuredFormat,
  });

  factory PlacesAutocomplete.fromJson(Map<String, dynamic> json) =>
      _$PlacesAutocompleteFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesAutocompleteToJson(this);
}
