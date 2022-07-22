// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutocompleteRequest _$AutocompleteRequestFromJson(Map<String, dynamic> json) =>
    AutocompleteRequest(
      input: json['input'] as String,
      location: json['location'] as String?,
      limit: json['limit'] as String? ?? '15',
      radius: json['radius'] as String? ?? '2000',
      sessionToken: json['sessionToken'] as String?,
      moreCompound: json['more_compound'] as String?,
    );

Map<String, dynamic> _$AutocompleteRequestToJson(AutocompleteRequest instance) {
  final val = <String, dynamic>{
    'input': instance.input,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('location', instance.location);
  writeNotNull('limit', instance.limit);
  writeNotNull('radius', instance.radius);
  writeNotNull('sessionToken', instance.sessionToken);
  writeNotNull('more_compound', instance.moreCompound);
  return val;
}
