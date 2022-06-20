import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable(includeIfNull: false)
class AuthRequest {
  @JsonKey(name: 'phone_number')
  String phoneNumber;

  @JsonKey(name: 'password')
  String password;

  AuthRequest({
    required this.phoneNumber,
    required this.password,
  });

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
