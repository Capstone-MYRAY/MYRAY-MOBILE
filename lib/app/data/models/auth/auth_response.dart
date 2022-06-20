import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable(includeIfNull: false)
class AuthResponse {
  @JsonKey(name: 'token')
  String? token;

  @JsonKey(name: 'refresh_token')
  String? refreshToken;

  AuthResponse({
    this.token,
    this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
