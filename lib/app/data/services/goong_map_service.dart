import 'dart:convert';

import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:myray_mobile/app/data/models/goong_map/goong_map_models.dart';
import 'package:myray_mobile/app/data/providers/goong_map/goong_map_provider.dart';

class GoongMapService {
  final _provider = Get.find<GoongMapProvider>();

  Future<List<PlacesAutocomplete>?> autocomplete(
      AutocompleteRequest data) async {
    final response =
        await _provider.getMethod('/Place/AutoComplete', query: data.toJson());
    if (response.hasError) return null;

    final body = response.body;
    if (body == null) return null;

    return (body['predictions'] as List)
        .map((json) => PlacesAutocomplete.fromJson(json))
        .toList();
  }

  Future<PlaceDetails> getPlaceDetails(String placeId) async {
    final response =
        await _provider.getMethod('/geocode', query: {'place_id': placeId});
    return PlaceDetails.fromJson(response.body['results'].first);
  }

  Future<String> getAddressByLatLng(LatLng location) async {
    Map<String, dynamic> query = {
      'latlng': '${location.latitude},${location.longitude}'
    };
    final response = await _provider.getMethod('/geocode', query: query);
    if (response.hasError || response.body == null) return '';
    print(response.body.toString());
    return response.body['results'].first['formatted_address'];
  }
}
