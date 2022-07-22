import 'package:json_annotation/json_annotation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

part 'place_details.g.dart';

@JsonSerializable(includeIfNull: false)
class PlaceDetails {
  @JsonKey(name: 'formatted_address')
  String address;

  @JsonKey(name: 'geometry', fromJson: _locationFromJson)
  LatLng location;

  static _locationFromJson(Object json) {
    if (json is Map<String, dynamic>) {
      return LatLng(json['location']['lat'], json['location']['lng']);
    }
  }

  PlaceDetails({required this.address, required this.location});

  factory PlaceDetails.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailsToJson(this);
}
