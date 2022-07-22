import 'package:json_annotation/json_annotation.dart';

part 'autocomplete_request.g.dart';

@JsonSerializable(includeIfNull: false)
class AutocompleteRequest {
  String input;
  String? location;

  @JsonKey(name: 'limit', defaultValue: '15')
  String? limit;

  @JsonKey(name: 'radius', defaultValue: '2000')
  String? radius;

  String? sessionToken;

  @JsonKey(name: 'more_compound')
  String? moreCompound;

  AutocompleteRequest({
    required this.input,
    this.location,
    this.limit = '15',
    this.radius = '2000',
    this.sessionToken,
    this.moreCompound,
  });

  factory AutocompleteRequest.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AutocompleteRequestToJson(this);
}
