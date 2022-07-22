// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_autocomplete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesAutocomplete _$PlacesAutocompleteFromJson(Map<String, dynamic> json) =>
    PlacesAutocomplete(
      address: json['description'] as String,
      placeId: json['place_id'] as String,
      structuredFormat: StructuredFormat.fromJson(
          json['structured_formatting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlacesAutocompleteToJson(PlacesAutocomplete instance) =>
    <String, dynamic>{
      'description': instance.address,
      'place_id': instance.placeId,
      'structured_formatting': instance.structuredFormat.toJson(),
    };
